//
//  PullRequest.swift
//  ProjectMVC
//
//  Created by Edgar Costa Cardoso on 15/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

class PullRequest {
    let url: String
    let title: String
    let owner: String
    let image: String
    let description: String

    init?(jsonObject: JsonObject) {
        guard let url = jsonObject["url"] as? String,
            let title = jsonObject["title"] as? String,
            let description = jsonObject["body"] as? String,
            let user = jsonObject["user"] as? JsonObject,
            let owner = user["login"] as? String,
            let image = user["avatar_url"] as? String else {
                return nil
        }

        self.url = url
        self.title = title
        self.description = description
        self.owner = owner
        self.image = image
    }
}
