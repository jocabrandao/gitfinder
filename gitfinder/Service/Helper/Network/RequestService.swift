//
//  RequestService.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Represents the network verbs to do an API call.
///
/// - GET: read
/// - POST: create
/// - PUT: update or replace
/// - DELETE: remove
/// - PATCH: update or modify
enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

/// Service to encapsulate the REST API call complexity.
final class RequestService {
    
    /// Do a request over http
    ///
    /// - Parameters:
    ///   - method: network verb to do
    ///   - url: targuet API URL to call
    /// - Returns: request result received from the API called
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    /// Load some data from API over http
    ///
    /// - Parameters:
    ///   - urlString: url to call
    ///   - urlSession: provide an API for downloading content from url
    ///   - completion: result with the data obtained from the API call
    /// - Returns: The task created by the session is returned so that the calling code can have control of what is running.
    func loadData(urlString: String, urlSession: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return nil
        }
        
        let request = RequestService.request(method: .GET, url: url)
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request:" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
        return task
        
    }
    
}
