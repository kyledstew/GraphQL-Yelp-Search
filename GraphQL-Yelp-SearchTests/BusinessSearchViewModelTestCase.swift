//
//  GraphQL_Yelp_SearchTests.swift
//  GraphQL_Yelp_SearchTests
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import XCTest
@testable import GraphQL_Yelp_Search

class BusinessSearchViewModelTestCase: XCTestCase {

    var mockBusiness: Business {
        return Business(id: "",
                        name: "",
                        url: "",
                        rating: 0,
                        price: "",
                        display_phone: "",
                        photos: [],
                        categories: [],
                        location: Location(address1: "",
                                           address2: "",
                                           address3: "",
                                           city: "",
                                           state: "",
                                           country: "",
                                           postal_code: "",
                                           formatted_address: ""))
    }

    func testSearchEnteredNoInput() {
        let viewModel = BusinessSearchViewModel()
        viewModel.notify(event: .searchSelected)
        XCTAssertFalse(viewModel.state.loadingResults)
    }

    func testSearchEnteredWithInput() {
        let viewModel = BusinessSearchViewModel()
        viewModel.state.searchQuery.searchText = "Ramen"
        viewModel.state.searchQuery.locationText = "Portland"
        viewModel.notify(event: .searchSelected)
        XCTAssertTrue(viewModel.state.loadingResults)
    }

    func testSearchClearPriorResults() {
        let viewModel = BusinessSearchViewModel()
        viewModel.state.results.append(mockBusiness)
        viewModel.state.searchQuery.searchText = "Ramen"
        viewModel.state.searchQuery.locationText = "Portland"
        viewModel.notify(event: .searchSelected)
        XCTAssertTrue(viewModel.state.results.isEmpty)
    }

    func testResultsFound() {
        let viewModel = BusinessSearchViewModel()
        viewModel.state.loadingResults = true
        let searchDetails = SearchDetails(total: 1, business: [mockBusiness])
        viewModel.notify(event: .resultsLoaded(searchDetails))
        XCTAssertTrue(viewModel.state.results.count == 1)
        XCTAssertFalse(viewModel.state.loadingResults)
    }

    func testLoadMoreResults() {
        let viewModel = BusinessSearchViewModel()
        viewModel.notify(event: .loadMoreResultsSelected)
        XCTAssertTrue(viewModel.state.loadingResults)
    }
}
