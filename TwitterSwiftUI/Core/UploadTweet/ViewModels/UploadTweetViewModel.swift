//
//  UploadTweetViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            if success {
                self.didUploadTweet = true
            } else {
                print("error") // not handling the error, for now
            }
        }
    }
}
