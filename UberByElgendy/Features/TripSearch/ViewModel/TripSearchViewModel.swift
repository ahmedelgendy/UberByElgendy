//
//  TripSearchViewModel.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

class TripSearchViewModel {
    
    private let provider: TripsProvider
    private var trips = [Trip]()
    var onTripsFetched: () -> Void = {}
    private var selectedDistance: DistanceOption = .any
    private var selectedTime: TimeOption = .any
    private var includeCancelledTrips = true
    private var searchKeyword = ""
    var tripsCount: Int {
        trips.count
    }
    
    init(provider: TripsProvider) {
        self.provider = provider
    }
    
    func fetch() {
        provider.tripSearch { (result) in
            do {
                let data = try result.get()
                self.trips = data.trips
                self.onTripsFetched()
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    func includeCanceledTrips(_ include: Bool) {
        includeCancelledTrips = include
    }
    
    func setDistance(_ distance: DistanceOption?) {
        selectedDistance = distance ?? .any
    }
    
    func setTime(_ time: TimeOption?) {
        selectedTime = time ?? .any
    }
    
    func setSearchKeyword(_ keyword: String) {
        searchKeyword = keyword
    }
    
}

// MARK: - TripSearchResultsViewModel
extension TripSearchViewModel {
    func createTripSearchResultsViewModel() -> TripSearchResultsViewModel {
        let filteredTrips = filterTrips()
        let viewModel = TripSearchResultsViewModel(trips: filteredTrips)
        return viewModel
    }
}

// MARK: - Trips Filteration
extension TripSearchViewModel {
        
    func filterTrips() -> [Trip] {
        let returnAllPredicate: ((Trip) -> Bool) = { _ in return true }
        
        let cancelledTripsPredicate = includeCancelledTrips ? returnAllPredicate : composeFilters(first: returnAllPredicate, second: { $0.status != .canceled })
        
        let selectedTimeTrips = (selectedTime == .any) ? cancelledTripsPredicate : composeFilters(first: cancelledTripsPredicate, second: selectedTimePredicate())
        
        let selectedDistanceTrips = (selectedDistance == .any) ? selectedTimeTrips : composeFilters(first: selectedTimeTrips, second: selectedDistancePredicate())
        
        let keywordTrips = searchKeyword.isEmpty ? selectedDistanceTrips : composeFilters(first: selectedDistanceTrips, second: {$0.matches(query: self.searchKeyword)})
        
        return trips.filter(keywordTrips)
    }
    
    // a function to compose two filter conditions
    fileprivate func composeFilters(first: @escaping (Trip) -> Bool, second: @escaping (Trip) -> Bool) -> (Trip) -> Bool {
        return {
            return first($0) && second($0)
        }
    }
    
    fileprivate func selectedTimePredicate() -> ((Trip) -> Bool) {
        switch selectedTime {
        case .under5min:
            return {
                switch $0.durationUnit {
                case .sec: return $0.duration < 60
                case .min: return $0.duration < 5
                }
            }
        case .between5And10min:
            return { $0.duration > 5 && $0.duration <= 10 }
        case .between10And20min:
            return { $0.duration > 10 && $0.duration <= 20 }
        case .moreThan20min:
            return {  $0.duration > 20 }
        default:
            return { _ in return true }
        }
    }
    
    fileprivate func selectedDistancePredicate() -> ((Trip) -> Bool) {
        switch selectedDistance {
        case .under3km:
            return {
                switch $0.distanceUnit {
                case .m: return $0.distance < 1000
                case .km: return $0.distance < 3
                }
            }
        case .between3And8km:
            return {  $0.distance > 3.0 && $0.distance <= 8.0 }
        case .between8And15km:
            return { $0.distance > 8.0 && $0.distance <= 15.0 }
        case .moreThan15km:
            return {  $0.distance > 15.0 }
        default:
            return { _ in return true }
        }
    }
}
