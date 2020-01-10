//
//  Category.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct Category: Codable, GraphQLObject {
    var title: String
    var alias: String

    static var fieldsQuery: String {
        return """
        title
        alias
        """
    }
}
