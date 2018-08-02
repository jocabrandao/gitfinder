//
//  GitHubService.swift
//  gitfinder
//
//  Created by Joca on 31/07/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Interface that GitHub service need to provide
protocol GitHubServiceProtocol : class {
    
    /// Search by user on GitHub
    /// This search service allows you to search for users on GitHub via username, email or name.
    /// All of them can be used as search criteria, which the API will try to find.
    ///
    /// - Parameters:
    ///   - criteria: username, email or name
    ///   - completion: Closure with data searched or error, if happened
    /// - Returns: nothing
    func searchByUser(criteria: String, _ completion: @escaping ((Result<Developers, ErrorResult>) -> Void))
    
    /// Load User Profile on GitHub
    ///
    /// - Parameters:
    ///   - username: username to get profile
    ///   - completion: Closure with profile data or error, if happened
    /// - Returns: nothing
    func loadUserProfile(username: String, _ completion: @escaping ((Result<User, ErrorResult>) -> Void))
    
    /// Search by followers on GitHub
    ///
    /// - Parameters:
    ///   - username: username to get followers
    ///   - completion: Closure with followers data or error, if happened
    /// - Returns: nothing
    func searchUserFollowers(username: String, _ completion: @escaping ((Result<[Follower], ErrorResult>) -> Void))
    
}

final class GitHubService: RequestHandler, GitHubServiceProtocol {
    
    static let instance = GitHubService()
    
    var tasks = [String : URLSessionTask]()
    
    func searchByUser(criteria: String, _ completion: @escaping ((Result<Developers, ErrorResult>) -> Void)) {
      
        let taskKey = "searchByUserTaskKey"
        self.cancelPreviusRequest(forTaskKey: taskKey)
        let criteriaTrimmed = criteria.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let urlSearch = "\(BASE_URL_SEARCH_USER_GIT)\(criteriaTrimmed)"

        let task = RequestService().loadData(urlString: urlSearch, completion: networkResult(completion: completion))
        tasks[taskKey] = task
        
    }
    
    func loadUserProfile(username: String, _ completion: @escaping ((Result<User, ErrorResult>) -> Void)) {
        let taskKey = "loadUserProfileTaskKey"
        self.cancelPreviusRequest(forTaskKey: taskKey)
        
        let urlProfile = "\(BASE_URL_LOAD_USER_GIT)\(username)"
        
        let task = RequestService().loadData(urlString: urlProfile, completion: networkResult(completion: completion))
        tasks[taskKey] = task
        
    }
    
    func searchUserFollowers(username: String, _ completion: @escaping ((Result<[Follower], ErrorResult>) -> Void)) {
        let taskKey = "loadUserProfileTaskKey"
        self.cancelPreviusRequest(forTaskKey: taskKey)
        
        let urlFollowers = "\(BASE_URL_LOAD_USER_GIT)\(username)/followers"
        
        let task = RequestService().loadData(urlString: urlFollowers, completion: networkResult(completion: completion))
        tasks[taskKey] = task
    }
    
    /// Cancel previus request if already in progress
    func cancelPreviusRequest(forTaskKey: String) -> Void {
        if let task = self.tasks[forTaskKey] {
            task.cancel()
            self.tasks.removeValue(forKey: forTaskKey)
        }
    }

}
