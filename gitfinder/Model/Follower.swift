//
//  Followers.swift
//  gitfinder
//
//  Created by Joca on 02/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Follower representation structure
struct Follower {
    let username: String
    let avatarUrl: String
    
    init(username: String, avatarUrl: String) {
        self.username = username
        self.avatarUrl = avatarUrl
    }

}

// MARK: - It makes the follower structure parcelable adopting the protocol
extension Follower: Parceable {
    
    static func parseToObject(dictionary: [String : AnyObject]) -> Result<Follower, ErrorResult> {
        
        let login = dictionary["login"] as? String ?? ""
        let avatar = dictionary["avatar_url"] as? String ?? ""
        
        let follower = Follower(username: login, avatarUrl: avatar)
        
        return Result.success(follower)
        
    }
    
}
