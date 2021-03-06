//
//  ProfileViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 6.03.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    private let service = TweetService()
    private let userService = UserService()
    let user: User
    
    init(userr: User) {
        self.user = userr
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
        case .tweets:
            return tweets
        case .replies:
            return tweets
        case .likes:
            return likedTweets
        }
    }
    
    func fetchUserTweets() {
        if let uid = user.id {
            service.fetchUserTweets(forUid: uid) { tweets in
                self.tweets = tweets
                for i in 0 ..< tweets.count {
                    self.tweets[i].user = self.user
                }
            }
        }
    }
    
    func fetchLikedTweets() {
        guard let uid = user.id else { return }
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< self.likedTweets.count {
                let uid = self.likedTweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
    }
}
