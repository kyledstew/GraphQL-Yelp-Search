//
//  SearchEndpoint.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct Yelp {}

extension Yelp {
    struct SearchEndpoint: YelpEndpoint {
        var query: GraphQLQuery
        var resultsCallback: (Result<SearchDetails, Error>) -> Void

        func handleSearchRequestCallback(_ result: Result<SearchQueryDataResponse, Error>) {
            switch result {
            case let .success(response):
                let searchData = response.data.search
                let urls = searchData.business.compactMap { URL(string: $0.photos?.first ?? "") }
                downloadImages(urls: urls) {
                    self.resultsCallback(.success(searchData))
                }

            case let .failure(error):
                resultsCallback(.failure(error))
            }
        }

        private func downloadImages(urls: [URL], completion: @escaping () -> Void) {
            let group = DispatchGroup()

            for url in urls {
                group.enter()
                DataController.downloadImage(url: url) {
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                completion()
            }
        
        }

        init(keyword: String, location: String, callback: @escaping (_ result: Result<SearchDetails, Error>) -> Void) {
            self.resultsCallback = callback
            self.query = SearchQuery(term: keyword, location: location)
        }
    }
}
