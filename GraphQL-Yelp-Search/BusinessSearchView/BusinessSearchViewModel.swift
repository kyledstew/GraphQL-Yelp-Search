//
//  BusinessSearchViewModel.swift
//  Traeger-Code-Challenge
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

extension BusinessSearchViewModel {
    enum Event {
        case searchSelected
        case resultsLoaded(SearchDetails)
    }

    class State: ObservableObject {
        @Published var searchText: String = ""
        @Published var locationText: String = ""
        @Published var loadingResults: Bool = false

        @Published var results: [Business] = []
    }
}

extension BusinessSearchViewModel: ViewModel {
    func notify(event: Event) {
        switch event {
        case .searchSelected:
            guard !state.searchText.isEmpty, !state.locationText.isEmpty else { break }
            state.loadingResults = true
            DataController.searchYelp(keyword: state.searchText, location: state.locationText, callback: handleSearchCallback)

        case let .resultsLoaded(results):
                state.loadingResults = false
                state.results = results.business
        }
    }

    func handleSearchCallback(_ results: (Result<SearchDetails, Error>)) {
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
