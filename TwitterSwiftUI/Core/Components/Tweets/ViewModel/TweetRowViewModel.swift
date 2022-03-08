//
//  TweetRowViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 7.03.2022.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    private let service = TweetService()
    @Published var  tweet: Tweet
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfLikedTweet()
    }
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
    
    func unlikeTweet() {
        service.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
    
    func checkIfLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.didLike = true
            }
        }
    }
}
 
