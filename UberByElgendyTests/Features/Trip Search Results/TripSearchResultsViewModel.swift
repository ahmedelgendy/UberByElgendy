//
//  TripSearchResultsViewModel.swift
//  UberTests
//
//  Created by Elgendy on 6.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import XCTest
@testable import Uber

class TripSearchResultsViewModelTest: XCTestCase {
    
    var sut: TripSearchResultsViewModel!

    override func setUp() {
        sut = TripSearchResultsViewModel(trips: getTrips())
    }

    override func tearDown() {
        
    }
    
    func testTripStatus_whenInitialized_isEqualCompleted() {
        XCTAssertEqual(sut.tripStatus, .completed)
    }
    
    func testNumberOfItems_whenTripStatusIsCompleted_isEqual2() {
        XCTAssertEqual(sut.numberOfItems, 2)
    }
    
    func testNumberOfItems_whenTripStatusIsCanceled_isEqual1() {
        sut.changeTripStatus(.canceled)
        XCTAssertEqual(sut.numberOfItems, 1)
    }
    
    func testTrip_whenTripStatusIsCanceled_isReturnedProperly() {
        sut.changeTripStatus(.canceled)
        let object = sut.dataForRowAt(index: 0)
        XCTAssertEqual(object.id, getTrips()[0].id)
    }
    
    func testTrip_whenTripStatusIsCompleted_isReturnedProperly() {
         let object = sut.dataForRowAt(index: 1)
         XCTAssertEqual(object.id, getTrips()[2].id)
     }
    
}

extension TripSearchResultsViewModelTest {
    private func getTrips() -> [Trip] {
        return [
            Trip(id: 0, status: .canceled, requestDate: "", pickupLat: 0, pickupLng: 0, pickupLocation: "", dropoffLat: 0, dropoffLng: 0, dropoffLocation: "", pickupDate: "", dropoffDate: "", type: "", driverId: 0, driverName: "", driverRating: 0, driverPic: "", carMake: "", carModel: "", carNumber: "", carYear: 0, carPic: "", duration: 0, durationUnit: .min, distance: 0, distanceUnit: .km, cost: 0, costUnit: ""),
             Trip(id: 1, status: .completed, requestDate: "", pickupLat: 0, pickupLng: 0, pickupLocation: "", dropoffLat: 0, dropoffLng: 0, dropoffLocation: "", pickupDate: "", dropoffDate: "", type: "", driverId: 0, driverName: "", driverRating: 0, driverPic: "", carMake: "", carModel: "", carNumber: "", carYear: 0, carPic: "", duration: 0, durationUnit: .min, distance: 0, distanceUnit: .km, cost: 0, costUnit: ""),
              Trip(id: 2, status: .completed, requestDate: "", pickupLat: 0, pickupLng: 0, pickupLocation: "", dropoffLat: 0, dropoffLng: 0, dropoffLocation: "", pickupDate: "", dropoffDate: "", type: "", driverId: 0, driverName: "", driverRating: 0, driverPic: "", carMake: "", carModel: "", carNumber: "", carYear: 0, carPic: "", duration: 0, durationUnit: .min, distance: 0, distanceUnit: .km, cost: 0, costUnit: "")
        ]
    }
}
