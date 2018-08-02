//
//  ResultError.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// It classifies the errors that occur to give better treatment to them.
///
/// - parser: when a parser error was identified.
/// - network: 
/// - custom: allows you to customize the information of an error
enum ErrorResult: Error {
    case parser(string: String)
    case network(string: String)
    case custom(string: String)
}
