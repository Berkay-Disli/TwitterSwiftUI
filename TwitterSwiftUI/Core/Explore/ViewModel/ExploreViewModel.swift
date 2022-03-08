//
//  ExploreViewModel.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    var searchableUsers: [User] {
        if searchText.isEmpty  {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            return users.filter({
                $0.username.lowercased().contains(lowercasedQuery) || $0.fullname.lowercased().contains(lowercasedQuery)
            })
            
        }
    }
    let service = UserService()
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { userarray in
            self.users = userarray
        }
    }
}
