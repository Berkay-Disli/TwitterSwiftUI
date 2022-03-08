//
//  TweetService.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import Foundation
import Firebase

struct TweetService {
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            let data = ["uid": uid, "caption": caption, "likes": 0, "timestamp": Timestamp(date: Date())] as [String:Any]
            Firestore.firestore().collection("tweets").document().setData(data) { error in
                if error != nil {
                    print("Failed to upload tweet with error: \(error?.localizedDescription ?? "no description")")
                    completion(false)
                } else if error == nil {
                    print("Tweet uploaded")
                    completion(true)
                }
            }
        }
    }
    
    func fetchTweet(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets").order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
            if error == nil {
                if let documents = snapshot?.documents {
                    let tweetsArray = documents.compactMap({try? $0.data(as: Tweet.self)})
                    completion(tweetsArray)
                }
            }
        }
    }
    
    func fetchUserTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets").whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, error in
            if error == nil {
                if let documents = snapshot?.documents {
                    let tweetsArray = documents.compactMap({try? $0.data(as: Tweet.self)})
                    completion(tweetsArray.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
            }
        }
    }
    
    
}

// Likes
extension TweetService {
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1]) { _ in
            userLikesRef.document(tweetId).setData([:]) { _ in
                completion()
            }
        }
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else {return}
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes - 1]) { _ in
            userLikesRef.document(tweetId).delete { _ in
                completion()
            }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        Firestore.firestore().collection("users").document(uid).collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { doc in
                let tweetID = doc.documentID
                Firestore.firestore().collection("tweets").document(tweetID).getDocument { snapshot, _ in
                    
                    guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
