//
//  BusinessSearchViewModel.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

class BusinessSearchViewModel {
    var state: State

    init() {
        state = State()
    }
}

// MARK: - Objects used by ViewModel
extension BusinessSearchViewModel {
    enum Event {
        case searchSelected
        case resultsLoaded(SearchDetails)
        case loadMoreResultsSelected
    }

    class SearchQuery: ObservableObject {
        @Published var searchText: String = ""
        @Published var locationText: String = ""

        var isValid: Bool {
            return !searchText.isEmpty && !locationText.isEmpty
        }
    }

    class State: ObservableObject {
        @Published var searchQuery = SearchQuery()
        @Published var loadingResults: Bool = false
        @Published var results: [Business] = []
    }
}

// MARK: - Conform to `ViewModel`
extension BusinessSearchViewModel: ViewModel {
    func notify(event: Event) {
        switch event {
        case .searchSelected:
            guard state.searchQuery.isValid else { break}
            state.results.removeAll()
            state.loadingResults = true
            queryMoreData()

        case let .resultsLoaded(results):
            state.loadingResults = false
            state.results.append(contentsOf: results.business)

        case .loadMoreResultsSelected:
            state.loadingResults = true
            queryMoreData()
        }
    }

    func queryMoreData() {
        DataController.searchYelp(keyword: state.searchQuery.searchText,
                                  location: state.searchQuery.locationText,
                                  offset: state.results.count,
                                  resultCompletion: handleSearchResult)
    }

    func handleSearchResult(_ results: (Result<SearchDetails, Error>)) {
        switch results {
        case let .success(results):
            DispatchQueue.main.async {
                self.notify(event: .resultsLoaded(results))
            }

        case let .failure(error):
            print(error)
        }

    }
}
