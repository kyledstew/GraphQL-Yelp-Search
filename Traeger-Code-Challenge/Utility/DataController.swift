//
//  DataController.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

struct DataController {
    static func searchYelp(keyword: String, location: String, callback: @escaping (Result<SearchDetails, Error>) -> Void) {
        let searchEndpoint = Yelp.SearchEndpoint(keyword: keyword, location: location, callback: callback)
        searchEndpoint.makeRequest()
    }

    static func downloadImage(url: URL, callback: @escaping () -> Void) {
        ImageCacher.downloadImage(url: url, callback: callback)
    }
}
