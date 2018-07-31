//
//  Parser.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseToObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class Parser {
    
    /// Parser Json collection data and return a list of objects
    ///
    /// - Parameters:
    ///   - data: json data to parser
    ///   - completion: .success with data parsed or .failure with parser error message
    static func toObject<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                
                // init final result as an array of objects
                var finalResult : [T] = []
                
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        
                        // foreach item check if the dictionary is parseable with the class that implement Parceable protocol
                        switch T.parseToObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                
                completion(.success(finalResult))
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
            
        } catch {
            // can't parser json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    /// Parser Json data and return an object
    ///
    /// - Parameters:
    ///   - data: json data to parser
    ///   - completion: .success with data parsed or .failure with parser error message
    static func toObject<T: Parceable>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {
        
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] {
                
                // foreach item check if the dictionary is parseable with the class that implement Parceable protocol
                switch T.parseToObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
                
            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
            
        } catch {
            // can't parser json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
        
    }
    
    
}
