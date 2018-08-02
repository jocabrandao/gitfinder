//
//  DetailVM.swift
//  gitfinder
//
//  Created by Joca on 02/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Intermediary between View and Module. Doing the job of requesting and delivering information.
struct DetailVM {
    
    weak var sv : GitHubServiceProtocol?
    weak var dsProfile : GenericDS<User>?
    weak var dsFollowers : GenericDS<Follower>?
    var selectedUser : User?
    
    init(service: GitHubServiceProtocol = GitHubService.instance, selectedUser: User?, datasourceProfile: GenericDS<User>?, datasourceFollowers: GenericDS<Follower>) {
        self.sv = service
        self.dsProfile = datasourceProfile
        self.dsFollowers = datasourceFollowers
        self.selectedUser = selectedUser
    }
    
    /// Search by followers on GitHub
    ///
    /// - Parameter completion: Closure with true or error, if happened
    func searchUserFollowers(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let sv = self.sv else {
            completion?(Result.failure(ErrorResult.custom(string: "GitHubService is missing")))
            return
        }
        
        guard let selectedUsername = self.selectedUser?.username else {
            completion?(Result.failure(ErrorResult.custom(string: "Username is missing")))
            return
        }
        
        sv.searchUserFollowers(username: selectedUsername) { (result) in
            switch result {
            case .success(let followers):
                self.dsFollowers?.data.value = followers
                completion?(Result.success(true))
                break
            case .failure(let error):
                print("[DetailVM -> searchUserFollowers] Error: \(error)")
                completion?(Result.failure(error))
                break
            }
        }
    }
    
    /// Load User Profile on GitHub
    ///
    /// - Parameter completion: Closure with true or error, if happened
    func loadUserProfile(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let sv = self.sv else {
            completion?(Result.failure(ErrorResult.custom(string: "GitHubService is missing")))
            return
        }
        
        guard let selectedUsername = self.selectedUser?.username else {
            completion?(Result.failure(ErrorResult.custom(string: "Username is missing")))
            return
        }
    
        sv.loadUserProfile(username: selectedUsername) { (result) in
            switch result {
            case .success(let userProfile):
                self.dsProfile?.data.value = [userProfile]
                completion?(Result.success(true))
                break
            case .failure(let error):
                print("[DetailVM -> loadUserProfile] Error: \(error)")
                completion?(Result.failure(error))
                break
            }
        }
    
    }
    
}
