//
//  iTunes_SearchTests.swift
//  iTunes SearchTests
//
//  Created by Jessie Ann Griffin on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class iTunes_SearchTests: XCTestCase {

    func testSuccessfulSearch() {
        
        let searchResultsController = SearchResultController()
        searchResultsController.performSearch(for: "Tweetbot", resultType: .software) { result in
            switch result {
            case .success(let result):
//                XCTAssert(result.count > 0)
                XCTFail("The search function failed")

            case .failure(let error):
                XCTFail("The search function failed \(error)")
            }
        }
    }
}
