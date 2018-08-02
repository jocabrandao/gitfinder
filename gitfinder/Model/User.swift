//
//  User.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// User representation structure
struct User {
    let username: String
    let avatarUrl: String
    var name: String!
    var email: String!
    var publicRepos: Int!
    var followers: Int!
    
    init(username: String, avatarUrl: String) {
        self.username = username
        self.avatarUrl = avatarUrl
    }
    
    init(username: String, avatarUrl: String, name:String, email: String, publicRepos: Int, followers: Int) {
        self.username = username
        self.avatarUrl = avatarUrl
        self.name = name
        self.email = email
        self.publicRepos = publicRepos
        self.followers = followers
    }
    
}

// MARK: - It makes the user structure parcelable adopting the protocol
extension User: Parceable {
    
    static func parseToObject(dictionary: [String : AnyObject]) -> Result<User, ErrorResult> {
        
        let login = dictionary["login"] as? String ?? ""
        let avatar = dictionary["avatar_url"] as? String ?? ""
        let name = dictionary["name"] as? String ?? ""
        let email = dictionary["email"] as? String ?? ""
        let publicRepos = dictionary["public_repos"] as? Int ?? 0
        let followers = dictionary["followers"] as? Int ?? 0
        
        let user = User(username: login, avatarUrl: avatar, name: name, email: email, publicRepos: publicRepos, followers: followers)
        return Result.success(user)
        
    }

}

