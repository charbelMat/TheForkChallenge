//
//  The_ForkTests.swift
//  The ForkTests
//
//  Created by Charbel Mattar on 08/03/2022.
//

import XCTest
@testable import The_Fork

class The_ForkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testFetchRestaurants() throws {
        let statusExpectation = expectation(description: "status")
        RestaurantsDataModel.shared.fetchRestaurants { status in
            print(status)
            XCTAssertEqual(status, 1)
            self.testSortByName()
            self.testSortByRating()
            statusExpectation.fulfill()
        }
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(statusExpectation)
        }
    }

    func testSortByName() {
        let array = RestaurantsDataModel.shared.getAllSortedBy(sortingType: "name")
        XCTAssert((array as Any) is [RestaurantModel])
    }
    
    func testSortByRating() {
        let array = RestaurantsDataModel.shared.getAllSortedBy(sortingType: "rating")
        XCTAssert((array as Any) is [RestaurantModel])
    }
    
    func testAddFavorite() throws {
        RestaurantsDataModel.shared.setFavorite(uuid: "4eg4e2bn-1080-4e1e-8438-6t90ht1230936", isFav: "1")
    }
    
    func testRemoveFavorite() throws {
        RestaurantsDataModel.shared.setFavorite(uuid: "4eg4e2bn-1080-4e1e-8438-6t90ht1230936", isFav: "0")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
