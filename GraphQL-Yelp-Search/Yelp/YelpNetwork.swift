//
//  YelpNetwork.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct YelpNetworkConstants {
    static let clientID = "dWIfzxTQC6tM-mF5HO6FhA"
    static let apiKey = "tOayFdeF4m3twrJsXHu6kUbNDVaHnIewJRlMrCrT2Bcm0i3Tk-rx7Q35YzLXob367SoBneVUeW1Upn0o_pp8wsSukiVzInNBVOC66k-0VoYCrI7f22xvzEgWS6sWXnYx"
}

struct YelpRequest<T> {
    var queryBody: Data
    var responseType: T.Type
    var completionHandler: (Result<T, Swift.Error>) -> Void
}

extension YelpRequest where T: Codable {
    func perform() {
        var urlRequest = URLRequest(url: URL(string: "https://api.yelp.com/v3/graphql")!)
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

    func handleResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        if let error = error {
            self.completionHandler(.failure(error))
            return
        }

        if let data = data {
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(self.responseType.self, from: data)
                self.completionHandler(.success(parsedData))
            } catch {
                self.completionHandler(.failure(error))
            }
            return
        }
    }
}
