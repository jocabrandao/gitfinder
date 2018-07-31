//
//  RequestHandler.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

class RequestHandler {
    
    func networkResult<T: Parceable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in
                
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case .success(let data):
                        Parser.toObject(data: data, completion: completion)
                        break
                    case .failure(let error):
                        completion(.failure(.network(string: "Network error \(error.localizedDescription)")))
                        break
                    }
                })
                
            }
    }
    
    func networkResult<T: Parceable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in
                
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case .success(let data):
                        Parser.toObject(data: data, completion: completion)
                        break
                    case .failure(let error):
                        completion(.failure(.network(string: "Network error \(error.localizedDescription)")))
                        break
                    }
                })
                
            }
    }
}
