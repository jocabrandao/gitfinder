//
//  GitHubService.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

protocol GitHubServiceProtocol {
    func searchByUser(_ completion: @escaping ((Result<Developers, ErrorResult>) -> Void))
    func searchUserFollowers(_completion: @escaping ((Result<User, ErrorResult>) -> Void))
}

final class GitHubService: RequestHandler, GitHubServiceProtocol {
    
    static let instance = GitHubService()
    var task: URLSessionTask?
    
    func searchByUser(_ completion: @escaping ((Result<Developers, ErrorResult>) -> Void)) {
        
        self.cancelPreviusRequest()
        
        task = RequestService().loadData(urlString: URL_FIND_USER_GIT, completion: networkResult(completion: completion))
        
    }
    
    func searchUserFollowers(_completion: @escaping ((Result<User, ErrorResult>) -> Void)) {
        print("Implement the search followers")
    }
    
    /// Cancel previus request if already in progress
    func cancelPreviusRequest() -> Void {
        if let task = task {
            task.cancel()
        }
        task = nil
    }

}
