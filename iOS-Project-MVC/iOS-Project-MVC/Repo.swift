//
//  Repo.swift
//  iOS-Project-MVC
//
//  Created by Edgar Costa Cardoso on 14/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

class Repo {
    let name: String
    let owner: String
    let image: String
    let type: String
    let description: String
    let forks: Int
    let stars: Int
    
    init?(jsonObject: JsonObject) {
        guard let name = jsonObject["name"] as? String,
            let description = jsonObject["description"] as? String,
            let owner = jsonObject["owner"] as? JsonObject,
            let ownerName = owner["login"] as? String,
            let image = owner["avatar_url"] as? String,
            let type = owner["type"] as? String,
            let forks = jsonObject["forks_count"] as? Int,
            let stars = jsonObject["stargazers_count"] as? Int else {
                return nil
        }
        
        self.name = name
        self.description = description
        self.owner = ownerName
        self.type = type
        self.image = image
        self.forks = forks
        self.stars = stars
    }
}
