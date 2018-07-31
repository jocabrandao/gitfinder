//
//  Result.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Represents the events that may occur while executing an API call.
///
/// - success: when an API call is reached the goal, without error occurrence.
/// - failure: when an API call does not reach the goal, an error occurs.
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
