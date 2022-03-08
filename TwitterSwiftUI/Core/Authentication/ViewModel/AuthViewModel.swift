//
//  AuthViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 28.02.2022.
//

import Foundation
import SwiftUI
import Firebase


class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func logIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                if let user = result?.user {
                    self.userSession = user
                    self.fetchUser()
                    print("User logged in ")
                }
            }
        }
    }
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                return
            } else {
                if let user = result?.user {
                    self.tempUserSession = user
                    
                    let data = ["email": email, "username": username, "fullname": fullname]
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        if error == nil {
                            self.didAuthenticateUser = true
                        }
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func uploadProfileImage(image: UIImage) {
        if let uid = tempUserSession?.uid {
            ImageUploader.uploadImage(image: image) { profileImageUrl in
                Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": profileImageUrl]) { error in
                    if error == nil {
                        self.userSession = self.tempUserSession
                        self.fetchUser()
                    }
                }
            }
        }
    }
    
    func fetchUser() {
        if let uid = self.userSession?.uid {
            service.fetchUser(withUid: uid) { user in
                self.currentUser = user
                print(self.currentUser?.fullname)
            }
        }
    }
}
