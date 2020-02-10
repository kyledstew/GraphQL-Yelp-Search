//
//  YelpNetwork.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

private struct YelpNetworkConstants {
    static let graphQLURL = URL(string: "https://api.yelp.com/v3/graphql")!
    static let clientID = "dWIfzxTQC6tM-mF5HO6FhA"
    static let apiKey = "tOayFdeF4m3twrJsXHu6kUbNDVaHnIewJRlMrCrT2Bcm0i3Tk-rx7Q35YzLXob367SoBneVUeW1Upn0o_pp8wsSukiVzInNBVOC66k-0VoYCrI7f22xvzEgWS6sWXnYx"
}

struct YelpRequest<T> {
    var queryBody: Data
    var responseType: T.Type
    var completionHandler: (Result<T, Swift.Error>) -> Void
}

extension YelpRequest where T: Codable {
    enum Error: Swift.Error {
        case noDataNoError
        case unableToParseData(Swift.Error)
    }

    func perform() {
        var urlRequest = URLRequest(url: YelpNetworkConstants.graphQLURL)
        let headers: [String: String] = [
            "Authorization": "Bearer \(YelpNetworkConstants.apiKey)",
            "Content-Type": "application/graphql",
            "Accept-Language": "en_US"
        ]
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "POST"

        urlRequest.httpBody = self.queryBody

        URLSession.shared.dataTask(with: urlRequest, completionHandler: handleResponse).resume()
    }

    func handleResponse(_ data: Data?, _ response: URLResponse?, _ error: Swift.Error?) {
        guard let data = data else {
            self.completionHandler(.failure(error ?? Error.noDataNoError))
            return
        }

        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(self.responseType.self, from: data)
            self.completionHandler(.success(parsedData))
        } catch {
            self.completionHandler(.failure(Error.unableToParseData(error)))
        }
        return
    }
}
