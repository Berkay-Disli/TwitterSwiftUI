//
//  User.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 2.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let fullname: String
    let profileImageUrl: String
}
