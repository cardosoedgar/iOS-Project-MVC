//
//  PullRequestManager.swift
//  ProjectMVC
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

class PullRequestsManager {
    private let repo: Repo
    private let requestManager: GithubRequest
    private var pullRequests = [PullRequest]()

    init(repo: Repo, requestManager: GithubRequest = GithubRequest()) {
        self.repo = repo
        self.requestManager = requestManager
    }

    func getPullRequests(completion: @escaping (Bool) -> Void) {
        requestManager.getPullRequests(repo: repo.name, user: repo.owner) { result in
            if let result = result {
                let response = result.compactMap({ return PullRequest(jsonObject: $0) })
                self.pullRequests = response
                return completion(true)
            }

            return completion(false)
        }
    }

    func getPullRequest(at index: Int) -> PullRequest? {
        if index < pullRequests.count {
            return pullRequests[index]
        }
        return nil
    }

    func getPullRequestCount() -> Int {
        return pullRequests.count
    }
    
    func getRepoName() -> String {
        return repo.name
    }
}
