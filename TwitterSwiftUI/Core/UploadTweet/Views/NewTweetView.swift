//
//  NewTweetView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 25.02.2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var uploadTweetViewModel = UploadTweetViewModel()
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                Spacer()
                Button {
                    uploadTweetViewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            HStack(alignment: .top) {
                if let user = viewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64 )
                }
                
                TextArea("What's happening?", text: $caption)
            }
            .padding()
        }
        .onReceive(uploadTweetViewModel.$didUploadTweet) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
