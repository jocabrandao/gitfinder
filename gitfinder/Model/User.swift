//
//  User.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let email: String!
    let avatarUrl: String
    let repositories: Int!
    let followers: [User]!
}
