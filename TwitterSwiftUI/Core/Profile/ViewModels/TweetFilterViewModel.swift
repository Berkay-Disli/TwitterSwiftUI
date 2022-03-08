//
//  TweetFilterViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 24.02.2022.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var Title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}

