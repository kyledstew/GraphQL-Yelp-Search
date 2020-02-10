//
//  Endpoint.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

protocol YelpEndpoint {
    typealias ResultCompletion = (_ result: Result<T, Error>) -> Void

    associatedtype QueryResponse
    associatedtype T

    var query: GraphQLQuery { get set }
    var resultCompletion: ResultCompletion { get set }

    func handleRequestResult(_ result: Result<QueryResponse, Error>)
}

extension YelpEndpoint where QueryResponse: Codable {
    func makeRequest() {
        YelpRequest(queryBody: query.queryData,
                    responseType: QueryResponse.self,
                    completionHandler: handleRequestResult(_:))
            .perform()
    }
}
