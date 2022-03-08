//
//  Tweet.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let uid: String
    let timestamp: Timestamp
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
