//
//  Business.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import UIKit

struct Business: Codable, GraphQLObject {
    var id: String
    var name: String
    var url: String
    var rating: Double?
    var price: String?
    var display_phone: String?
    var photos: [String]?
    var categories: [Category]
    var location: Location
    var image: UIImage? {
        guard let url = URL(string: photos?.first ?? "") else {
            return nil
        }
        return ImageCacher.getImage(url: url)
    }

    static var fieldsQuery: String {
        return """
        id
        name
        url
        rating
        price
        display_phone
        photos
        categories {\(Category.fieldsQuery)}
        location {\(Location.fieldsQuery)}
        """
    }
}
