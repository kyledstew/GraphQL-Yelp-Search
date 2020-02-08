//
//  BusinessSearchView.swift
//  GraphQL-Yelp-Search
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
            ZStack {
                VStack {
                    HStack {
                        TextField("Search",
                                  text: self.$state.searchQuery.searchText,
                                  onCommit: self.returnSelected)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 16)


                        TextField("Location",
                                  text: self.$state.searchQuery.locationText,
                                  onCommit: self.returnSelected)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing, 16)
                    }
                    Spacer()

                    List {
                        Section(footer: Button(action: loadMoreSelected, label: {
                            HStack {
                                Spacer()

                                Button(action: loadMoreSelected) {
                                    Text("Load More Results")
                                        .frame(height: 50)
                                }
                                Spacer()
                            }
                        })) {
                            ForEach(self.state.results, id: \.id) { business in
                                RestaurantInfoView(business: business)
                            }
                        }
                    }
                    .opacity(self.state.results.isEmpty ? 0 : 1)
                }
                .navigationBarTitle("GraphQL Yelp Search")

                ActivityIndicator(isAnimating: $state.loadingResults, style: .large)
            }
        }
    }

    // MARK: - Action Functions

    private func returnSelected() {
        viewModel.notify(event: .searchSelected)
    }

    private func loadMoreSelected() {
        viewModel.notify(event: .loadMoreResultsSelected)
    }
}

struct BusinessSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSearchView()
    }
}
