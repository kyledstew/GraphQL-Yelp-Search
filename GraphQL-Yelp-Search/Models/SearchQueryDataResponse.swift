//
//  SearchQueryDataResponse.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct SearchQueryDataResponse: Codable {
    var data: SearchResponse
}

struct SearchResponse: Codable {
    var search: SearchDetails
}

struct SearchDetails: Codable, GraphQLObject {
    var total: Int
    var business: [Business]

    static var fieldsQuery: String {
        return """
        total
        business {\(Business.fieldsQuery)}
        """
    }
}
