//
//  RestaurantInfoView.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 2/7/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct RestaurantInfoView: View {
    var business: Business

    @ObservedObject private var imageCacher: ImageCacher

    init(business: Business) {
        self.business = business
        let imageURLString = self.business.photos?.first ?? ""
        imageCacher = ImageCacher(url: URL(string: imageURLString))
    }

    private var friendlyRating: String {
        var value = "Rating: "
        if let rating = business.rating {
            value += "\(rating)"
        } else {
            value += "N/A"
        }
        return value
    }

    var body: some View {
        VStack {
            HStack {
                Text(self.business.name)
                    .padding()
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(height: 25)

            HStack(spacing: 8) {
                (imageCacher.image ?? Image("food"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 130)

                Spacer()

                VStack {
                    Text(self.business.location.formatted_address)
                        .font(.body)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)

                    Text(self.business.display_phone ?? "")
                        .foregroundColor(.gray)
                        .font(.body)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    HStack {
                        Text("Price: \(self.business.price ?? "n/a")")
                            .font(.body)

                        Spacer()

                        RatingView(rating: self.business.rating ?? 0.0)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
