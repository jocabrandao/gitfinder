//
//  Developer.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Developers representation structure
struct Developers {
    let total: Int
    let users: [User]
}

// MARK: - It makes the developers structure parcelable adopting the protocol
extension Developers: Parceable {
    
    static func parseToObject(dictionary: [String : AnyObject]) -> Result<Developers, ErrorResult> {
        if  let count = dictionary["total_count"] as? Int,
        let items = dictionary["items"] as? [Dictionary<String, Any>] {
            
            var lstUser = [User]()
            
            for user: Dictionary<String, Any> in items {
                if  let login = user["login"] as? String,
                    let avatarUrl = user["avatar_url"] as? String {
                    lstUser.append(User(username: login, avatarUrl: avatarUrl))
                }
            }
           
            let developers = Developers(total: count, users: lstUser)
            
            return Result.success(developers)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "There is no result with the expected contract to make the parser."))
        }
    }
    
}
