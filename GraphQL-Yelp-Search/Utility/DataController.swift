//
//  DataController.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct DataController {
    typealias SearchYelpCompletion = (Result<SearchDetails, Error>) -> Void
    static func searchYelp(keyword: String, location: String, limit: Int = 25, offset: Int = 0, resultCompletion: @escaping SearchYelpCompletion) {
        let searchEndpoint = Yelp.SearchEndpoint(keyword: keyword,
                                                 location: location,
                                                 limit: limit,
                                                 offset: offset,
                                                 resultCompletion: resultCompletion)
        searchEndpoint.makeRequest()
    }
}
