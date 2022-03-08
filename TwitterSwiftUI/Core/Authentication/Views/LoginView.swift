//
//  LoginView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 27.02.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            AuthenticationHeader(title1: "Hello!", title2: "Welcome back", color: .orange)
            
            VStack(spacing: 40) {
                Group {
                    CustomInputField(imageName: "envelope", placeholder: "email", text: $email)
                    CustomPasswordField(imageName: "lock", placeholder: "password", text: $password)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            .padding(.horizontal, 32) .padding(.top, 44)
            
            HStack{
                Spacer()
                NavigationLink {
                    Text("reset password view")
                } label: {
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(.top) .padding(.trailing, 24)
                }
            }
            
            Button {
                viewModel.logIn(withEmail: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                    Text("Sign Up!")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.orange)

        }
        .onTapGesture {
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
