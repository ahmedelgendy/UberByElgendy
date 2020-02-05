//
//  TripSearchViewModelTest.swift
//  UberTests
//
//  Created by Elgendy on 6.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import XCTest
@testable import Uber

class TripSearchViewModelTest: XCTestCase {

    var sut: TripSearchViewModel!
    
    override func setUp() {
        sut = TripSearchViewModel(provider: TripsProvider(network: Networking()))
    }

    override func tearDown() {
    }
    
    func testTripsCount_afterViewModelInitialization_isZero() {
        XCTAssertEqual(sut.tripsCount, 0)
    }

    func testTripCount_afterFetching_isEqualTo33() {
        loadTrips()
        XCTAssertEqual(self.sut.tripsCount, 33)
    }
    
    func testTripCount_whenCancelledTripsNotInculded_is30() {
        loadTrips()
        sut.includeCanceledTrips(false)
        XCTAssertEqual(sut.filterTrips().count, 30)
    }
    
    func testTripCount_whenDistanceUnder3km_isEqualTo7() {
        loadTrips()
        sut.setDistance(.under3km)
        XCTAssertEqual(sut.filterTrips().count, 7)
    }
    
    func testTripCount_whenDistanceMoreThan15_isEqualTo7() {
        loadTrips()
        sut.setDistance(.moreThan15km)
        XCTAssertEqual(sut.filterTrips().count, 7)
    }
    
    func testTripCount_whenFilteredByKeyword_isEqualTo1() {
        loadTrips()
        sut.setSearchKeyword("Bandari")
        XCTAssertEqual(sut.filterTrips().count, 1)
    }

    func testTripCount_whenTimeBetween10and20_isEqualTo4() {
        loadTrips()
        sut.setTime(.between10And20min)
        XCTAssertEqual(sut.filterTrips().count, 4)
    }
    
}

extension TripSearchViewModelTest {
    private func loadTrips(file: String = #file, line: Int = #line) {
        let expectation = self.expectation(description: #function)
        sut.fetch()
        sut.onTripsFetched = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
}
