//
//  RepoResponse.swift
//  iOS-Project-MVC
//
//  Created by Edgar Costa Cardoso on 14/05/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

class RepoResponse {
    let totalCount: Int
    let items: [Repo]

    init?(jsonObject: JsonObject) {
        guard let totalCount = jsonObject["total_count"] as? Int,
            let items = jsonObject["items"] as? [JsonObject] else {
                return nil
        }

        self.totalCount = totalCount
        self.items = items.compactMap({ return Repo(jsonObject: $0) })
    }
}
