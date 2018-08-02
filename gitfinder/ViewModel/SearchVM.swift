//
//  SearchVM.swift
//  gitfinder
//
//  Created by Joca on 01/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation

/// Intermediary between View and Module. Doing the job of requesting and delivering information.
struct SearchVM {

    weak var sv : GitHubServiceProtocol?
    weak var ds : GenericDS<User>?
    var searchCriteria : String?

    init(service: GitHubServiceProtocol = GitHubService.instance, searchCriteria : String, datasource: GenericDS<User>? ) {
        self.sv = service
        self.ds = datasource
        self.searchCriteria = searchCriteria
        
    }
    
    /// Search by user on GitHub
    /// This search service allows you to search for users on GitHub via username, email or name.
    /// All of them can be used as search criteria, which the API will try to find.
    ///
    /// - Parameter completion: Closure with true or error, if happened
    func searchByUser(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let sv = self.sv else {
            completion?(Result.failure(ErrorResult.custom(string: "GitHubService is missing")))
            return
        }
        
        guard let searchCriteria = self.searchCriteria else {
            completion?(Result.failure(ErrorResult.custom(string: "Criteria is missing")))
            return
        }
        
        sv.searchByUser(criteria: searchCriteria) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let developers):
                    self.ds?.data.value = developers.users
                    completion?(Result.success(developers.total > 0))
                    break
                case .failure(let error):
                    print("[SearchVM -> SearchByUser] Error: \(error)")
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }
    
}
