//
//  GithubRequest.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//

import Foundation

class GithubRequest {
    var networkRequest: NetworkRequestProtocol = NetworkRequest()
    
    func getRepos(page: Int, completion: @escaping ([JsonObject]?) -> Void) {
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(page)")!
        
        networkRequest.request(url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(.array (let response)):
                completion(response)
            default:
                completion(nil)
            }
        }
    }
    
    func getPullRequests(repo: String, user: String, completion: @escaping ([JsonObject]?) -> Void) {
        let url = URL(string: "https://api.github.com/repos/\(user)/\(repo)/pulls")!
        
        networkRequest.request(url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(.array (let response)):
                completion(response)
            default:
                completion(nil)
            }
        }
    }
}
