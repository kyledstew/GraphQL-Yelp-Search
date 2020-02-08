//
//  RatingView.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 2/7/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    var rating: Double

    var wholeStars: Int {
        return Int(rating)
    }

    var includeHalfStar: Bool {
        return rating.truncatingRemainder(dividingBy: 1) != 0
    }

    var unfilledStars: Int {
        return 5 - wholeStars - (includeHalfStar ? 1 : 0)
    }

    var body: some View {
        HStack(spacing: 2) {
            ForEach((1...wholeStars), id: \.self) { _ in
                Image(systemName: "star.fill")
            }

            if includeHalfStar {
                Image(systemName: "star.lefthalf.fill")
            }

            if unfilledStars > 0 {
                ForEach((1...unfilledStars), id: \.self) { _ in
                    Image(systemName: "star")
                }
            }
        }
    }
}
