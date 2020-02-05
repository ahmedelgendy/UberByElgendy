//
//  Trip.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation


// MARK: - TripSearchResponse
public struct TripSearchResponse: Codable {
    let trips: [Trip]
}

// MARK: - Trip
public struct Trip: Codable {
    let id: Int
    let status: TripStatus
    let requestDate: String
    let pickupLat, pickupLng: Double
    let pickupLocation: String
    let dropoffLat, dropoffLng: Double
    let dropoffLocation, pickupDate: String
    let dropoffDate: String?
    let type: String
    let driverId: Int
    let driverName: String
    let driverRating: Int
    let driverPic: String
    let carMake: String
    let carModel: String
    let carNumber: String
    let carYear: Int
    let carPic: String
    let duration: Int
    let durationUnit: DurationUnit
    let distance: Double
    let distanceUnit: DistanceUnit
    let cost: Int
    let costUnit: String
    
    var finalCost: String {
        return "\(cost) \(costUnit)"
    }
    
    var distanceWithUnit: String {
        return "\(distance) \(distanceUnit.rawValue)"
    }
    
    var durationWithUnit: String {
        return "\(duration) \(durationUnit.rawValue)"
    }
    
}

extension Trip: Searchable {
    func matches(query: String) -> Bool {
        let searchFields = [requestDate, pickupLocation, dropoffLocation, pickupDate, (dropoffDate ?? ""), type, driverName, carMake, carModel, carNumber]
        return searchFields.contains(where: { $0.matches(query: query) })
    }
}


// MARK: - TripStatus
enum TripStatus: String, Codable {
    case completed = "COMPLETED"
    case canceled = "CANCELED"
}

enum DistanceUnit: String, Codable {
    case m = "m"
    case km = "km"
}

enum DurationUnit: String, Codable {
    case sec = "sec", min = "min"
}
