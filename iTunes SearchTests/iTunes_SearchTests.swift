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
        
        let searchExpectation = expectation(description: "Waiting for results.")
        
        let searchResultsController = SearchResultController()
        let mockAPI = MockAPI()
        searchResultsController.performSearch(for: "Tweetbot", resultType: .software, session: mockAPI) { result in
            
            switch result {
            case .success(let result):
                XCTAssert(result.count > 0)
                
            case .failure(let error):
                XCTFail("The search function failed \(error)")
            }
            
            // Continue with the function
            searchExpectation.fulfill() // happening on another thread
            
        }
        
        // Wait for the results
        // Blocking the main thread from executing (never ever block the main thread in the actualy app)
        wait(for: [searchExpectation], timeout: 5)
    }
    
    func testFailedSearch() {
          
          let searchExpectation = expectation(description: "Waiting for results.")
          
          let searchResultsController = SearchResultController()
          let mockAPI = MockAPI()
          searchResultsController.performSearch(for: "Tweetbot", resultType: .software, session: mockAPI) { result in
              
              switch result {
              case .success:
                  XCTFail("The search function succeeded when we expected it to failed")

              case .failure:
                break
              }
              
              // Continue with the function
              searchExpectation.fulfill() // happening on another thread
              
          }
          
          // Wait for the results
          // Blocking the main thread from executing (never ever block the main thread in the actualy app)
          wait(for: [searchExpectation], timeout: 5)
      }
    
    func testMockSuccessSearch() {
          
          let searchExpectation = expectation(description: "Waiting for results.")
          
          let searchResultsController = SearchResultController()
          let mockAPI = MockAPI()
          searchResultsController.performSearch(for: "Tweetbot", resultType: .software, session: mockAPI) { result in
              
              switch result {
              case .success(let arrayOfResults):
                XCTAssert(arrayOfResults.count == 2, "Expected 2 results but got \(arrayOfResults.count)")
                  
              case .failure(let error):
                  XCTFail("Unexpected failure \(error)")
              }
              
              // Continue with the function
              searchExpectation.fulfill() // happening on another thread
              
          }
          
          // Wait for the results
          // Blocking the main thread from executing (never ever block the main thread in the actualy app)
          wait(for: [searchExpectation], timeout: 5)
      }
}
