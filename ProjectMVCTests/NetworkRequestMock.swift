//
//  NetworkRequestMock.swift
//  ProjectMVCTests
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Alamofire

@testable import ProjectMVC

class NetworkRequestMock: NetworkRequestProtocol {
    let json: Json?
    let error: Bool

    init(json: Json? = nil, error: Bool = false) {
        self.json = json
        self.error = error
    }

    func request(_ url: URL, method: HTTPMethod, parameters: [String: Any]?,
                 headers: [String: String]?, completion: @escaping (ProjectMVC.Result<Json>) -> Void) {
        if error {
            completion(.error)
            return
        }

        guard let json = self.json else {
            completion(.error)
            return
        }

        completion(.success(json))
    }
}
