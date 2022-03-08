//
//  ProfilePhotoSelectorView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 28.02.2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    let color = Color(hue: 0.621, saturation: 1.0, brightness: 0.631)
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            AuthenticationHeader(title1: "Go ahead!", title2: "Select a profile photo", color: color)
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .padding(.top, 44)
                } else {
                    ZStack {
                        Circle().stroke(color, lineWidth: 4)
                            .frame(width: 180, height: 180)
                        VStack(spacing: 10) {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("Photo")
                                .font(.title)
                        }
                        .foregroundColor(color)
                    }
                    .padding(.top, 44)
                    
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(image: selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(color)
                        .clipShape(Capsule())
                        .padding(40)
                }
                .shadow(color: .gray.opacity(0.5), radius: 10)
            }

            
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            image = Image(uiImage: selectedImage)
        }
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
