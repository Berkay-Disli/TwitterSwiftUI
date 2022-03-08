//
//  FeedViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    let service = TweetService()
    @Published var tweets = [Tweet]()
    let userService = UserService()
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweet { tweetsArray in
            self.tweets = tweetsArray
            
            for i in 0 ..< tweetsArray.count {
                let uid = self.tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
