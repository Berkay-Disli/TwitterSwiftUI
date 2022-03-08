//
//  RegistirationView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 27.02.2022.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            
            NavigationLink(isActive: $viewModel.didAuthenticateUser) {
                ProfilePhotoSelectorView()
            } label: {
                //
            }

            
            AuthenticationHeader(title1: "Get started!", title2: "Create your account", color: .orange)
            VStack(spacing: 40) {
                Group {
                    CustomInputField(imageName: "envelope", placeholder: "email", text: $email)
                    CustomInputField(imageName: "person", placeholder: "username", text: $username)
                    CustomInputField(imageName: "person", placeholder: "fullname", text: $fullname)
                    CustomPasswordField(imageName: "lock", placeholder: "password", text: $password)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .padding(32)
            
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    Text("Sign In!")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.orange)

        }
        .ignoresSafeArea()
    }
}

struct RegistirationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
