//
//  UserService.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 2.03.2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    if let user = try? snapshot.data(as: User.self) {
                        completion(user)
                    }
                }
            }
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if error == nil {
                if let documents = snapshot?.documents {
                    let users = documents.compactMap({try? $0.data(as: User.self)})
                    completion(users)
                }
                        
            }
        }
    }
}
