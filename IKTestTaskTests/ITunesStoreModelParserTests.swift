//
//  ITunesStoreModelParserTests.swift
//  IKTestTaskTests
//
//  Created by Kukshtel I. on 8/7/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import XCTest
@testable import IKTestTask


final class ITunesStoreModelParserTests: XCTestCase {
    
    func testParsingModels_fromCorrectJSON() {
        let json = [
            [
                "trackName": "Test",
                "kind": "Test",
                "artworkUrl100": "Test"
            ],
            [
                "trackName": "Test2",
                "kind": "Test2",
                "artworkUrl100": "Test2"
            ]]
        
        let models = ITunesStoreModelParser.parse(json: json as [[String : AnyObject]])
        
        XCTAssertTrue(models.count == 2)
        XCTAssertTrue(models[0].name == "Test")
        XCTAssertTrue(models[1].kind == "Test2")
    }
}
