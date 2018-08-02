//
//  GenericDS.swift
//  gitfinder
//
//  Created by Joca on 01/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

class GenericDS<T> : NSObject {
    var data: GenericValue<[T]> = GenericValue([])
}
