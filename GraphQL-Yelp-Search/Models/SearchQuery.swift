//
//  SearchQuery.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct SearchQuery: GraphQLQuery {
    var term: String
    var location: String
    var limit: Int
    var offset: Int

    var queryData: Data {
        let queryString = """
        {
        search(term: "\(term)",
        location: "\(location)",
        limit: \(limit),
        offset: \(offset)) { \(SearchDetails.fieldsQuery)}
        }
        """
        return queryString.data(using: .utf8) ?? Data()
    }
}
