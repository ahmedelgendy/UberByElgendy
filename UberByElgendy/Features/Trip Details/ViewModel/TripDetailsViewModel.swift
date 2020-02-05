//
//  TripDetailsViewModel.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

class TripDetailsViewModel {
    
    private let trip: Trip
    private let googleMapsProvider: GoogleMapsProvider
    
    init(trip: Trip, googleMapsProvider: GoogleMapsProvider) {
        self.trip = trip
        self.googleMapsProvider = googleMapsProvider
    }

    var tripStatus: TripStatus { return trip.status }
    var pickupDate: String { return trip.pickupDate.formattedDate() }
    var totalCost: String { return "Total Cost: \(trip.finalCost)" }
    var pickUpLocation: String { return trip.pickupLocation }
    var pickUpTime: String { return trip.pickupDate.formattedTime() }
    var dropOffLocation: String { return trip.dropoffLocation }
    var dropOffTime: String? { return trip.dropoffDate?.formattedTime() }
    var carModel: String { return "\(trip.carMake) \(trip.carModel)" }
    var carImageUrl: URL? { return URL(string: trip.carPic) }
    var distance: String { return trip.distanceWithUnit }
    var duration: String { return trip.durationWithUnit }
    var driverName: String { return trip.driverName }
    var driverImageUrl: URL? { return URL(string: trip.driverPic) }
    var driverRating: Int { return trip.driverRating }
        
    func pickupCoordinate() -> (lat: Double, lng: Double) {
        return (lat: trip.pickupLat, trip.pickupLng)
    }
    
    func dropoffCoordinate() -> (lat: Double, lng: Double) {
        return (lat: trip.dropoffLat, trip.dropoffLng)
    }
    
    func fetchRoutes(completion: @escaping (_ points: String?) -> Void) {
        let origin = "\(trip.pickupLat),\(trip.pickupLng)"
        let destination = "\(trip.dropoffLat),\(trip.dropoffLng)"
        googleMapsProvider.getRoutes(origin: origin, destination: destination) { (result) in
            switch result {
            case .success(let points):
                completion(points)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
