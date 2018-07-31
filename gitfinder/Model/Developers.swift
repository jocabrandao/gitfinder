//
//  Developer.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

struct Developers {
    let total: Int
    let users: [User]
}

extension Developers: Parceable {
    static func parseToObject(dictionary: [String : AnyObject]) -> Result<Developers, ErrorResult> {
        if  let count = dictionary["total_count"] as? Int,
        let items = dictionary["items"] as? [Dictionary<String, Any>] {
            
            var lstUser = [User]()
            
            for user: Dictionary<String, Any> in items {
                if  let login = user["login"] as? String,
                    let avatarUrl = user["avatar_url"] {
                    lstUser.append(User(username: login, email: "", avatarUrl: avatarUrl as! String, repositories: 0, followers: ))
                }
            }
           
            let developers = Developers(total: count, users: lstUser)
            
            return Result.success(developers)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "There is no result with the expected contract to make the parser."))
        }
    }
}
