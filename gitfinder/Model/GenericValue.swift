//
//  GenericValue.swift
//  gitfinder
//
//  Created by Joca on 01/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Generic data transfer between Model and ViewModel 
class GenericValue<T> {
    
    var value : T
        
    init(_ value: T) {
        self.value = value
    }
    
}
