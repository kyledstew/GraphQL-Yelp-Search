//
//  SearchEndpoint.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct Yelp {}

extension Yelp {
    struct SearchEndpoint: YelpEndpoint {
        var query: GraphQLQuery
        var resultCompletion: (Result<SearchDetails, Error>) -> Void

        func handleRequestResult(_ result: Result<SearchQueryDataResponse, Error>) {
            switch result {
            case let .success(response):
                self.resultCompletion(.success(response.data.search))

            case let .failure(error):
                resultCompletion(.failure(error))
            }
        }

        init(keyword: String, location: String, limit: Int, offset: Int, resultCompletion: @escaping (_ result: Result<SearchDetails, Error>) -> Void) {
            self.resultCompletion = resultCompletion
            self.query = SearchQuery(term: keyword, location: location, limit: limit, offset: offset)
        }
    }
}
