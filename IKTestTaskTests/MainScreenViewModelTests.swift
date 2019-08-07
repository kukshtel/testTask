//
//  MainScreenViewModelTests.swift
//  IKTestTaskTests
//
//  Created by Kukshtel I. on 8/7/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import XCTest
@testable import IKTestTask

final class MainScreenViewModelTests: XCTestCase {

        func testSearchResultsUpdated_onSuccessfulQuery() {
            let mockNetworkService = MockNetworkService()
            mockNetworkService.stubSearchResults = [ITunesStoreModel(name: "test1", kind: "test2", imageUrl: "test3"), ITunesStoreModel(name: "test4", kind: "test5", imageUrl: "test6")]
            let viewModel = MainScreenViewModel(networkService: mockNetworkService)
            
            viewModel.query = "test"
            
            XCTAssertTrue(viewModel.resultsArray.count == 2)
        }
    
}
    
final class MockNetworkService: NetworkServiceProtocol {
        
        var stubSearchResults: [ITunesStoreModel] = []
        func searchRequest(text: String, completion: @escaping ([ITunesStoreModel])-> Void) {
            completion(stubSearchResults)
        }
}
