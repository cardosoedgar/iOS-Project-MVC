//
//  ReposManager.swift
//  iOS-Project-MVC
//
//  Created by Edgar Costa Cardoso on 14/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

class ReposManager {
    private let request = GithubRequest()
    private var repos = [Repo]()
    
    func getRepos(page: Int, completion: @escaping (Bool) -> Void) {
        request.getRepos(page: page) { result in
            if let result = result {
                let response = RepoResponse(jsonObject: result)
                if let repos = response?.items {
                    self.repos = repos
                    completion(true)
                }
            }
            
            return completion(false)
        }
    }
    
    func getRepoCount() -> Int {
        return repos.count
    }
    
    func getRepo(at index: Int) -> Repo? {
        if index < repos.count {
            return repos[index]
        }
        return nil
    }
}
