//
//  Endpoint.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

protocol YelpEndpoint {
    var query: GraphQLQuery { get set }
    var resultsCallback: (_ result: Result<T, Error>) -> Void { get set }
    associatedtype QueryResponse
    associatedtype T
    func handleSearchRequestCallback(_ result: Result<QueryResponse, Error>)
}

extension YelpEndpoint where QueryResponse: Codable {
    func makeRequest() {
        let request = YelpRequest(queryBody: query.queryData,
                                  responseType: QueryResponse.self,
                                  requestCallback: handleSearchRequestCallback(_:))
        request.perform()
    }
}
