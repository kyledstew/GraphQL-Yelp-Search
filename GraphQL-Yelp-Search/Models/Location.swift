//
//  Location.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct Location: Codable, GraphQLObject {
    var address1: String
    var address2: String?
    var address3: String?
    var city: String
    var state: String
    var country: String
    var postal_code: String
    var formatted_address: String

    static var fieldsQuery: String {
        return """
        address1
        address2
        address3
        city
        state
        postal_code
        country
        formatted_address
        """
    }
}
