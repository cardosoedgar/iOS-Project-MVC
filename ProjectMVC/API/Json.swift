//
//  Json.swift
//  TesteConcrete-MVC
//
//  Created by Edgar Cardoso on 01/12/17.
//  Copyright © 2017 Concrete. All rights reserved.
//

typealias JsonObject = [String: Any]

enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])

    init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }

        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }

        return nil
    }
}
