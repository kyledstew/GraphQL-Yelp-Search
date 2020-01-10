//
//  BusinessSearchView.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct BusinessSearchView: View {
    var viewModel: BusinessSearchViewModel

    @ObservedObject var state: BusinessSearchViewModel.State

    init() {
        viewModel = BusinessSearchViewModel()
        state = viewModel.state
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: self.$state.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 16)

                    TextField("Location", text: self.$state.locationText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing, 16)
                }
                Spacer()

                Button(action: searchSelected) {
                    Text("SEARCH")
                }
                .disabled(state.loadingResults)
                .frame(width: 200, height: 50)
                .background(Color.orange.opacity(state.loadingResults ? 0.5 : 1))
                .foregroundColor(Color.white)
                .cornerRadius(25)
                .padding()

                List {
                    ForEach(self.state.results, id: \.id) { business in
                        RestaurantInfoView(business: business)
                    }
                }
            }
            .navigationBarTitle("GraphQL Yelp Search")
        }
    }

    func searchSelected() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        self.viewModel.notify(event: .searchSelected)
    }
}

struct BusinessSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSearchView()
    }
}

struct RestaurantInfoView: View {
    var business: Business

    var friendlyRating: String {
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
                Image(uiImage: self.business.image ?? UIImage())
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

                        Text(self.friendlyRating)
                            .font(.body)
                            .padding(.trailing, 16)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

