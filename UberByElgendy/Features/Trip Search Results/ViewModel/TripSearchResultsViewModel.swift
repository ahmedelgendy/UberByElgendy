//
//  TripSearchResultsViewModel.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

class TripSearchResultsViewModel {
    
    private var completedTrips: [Trip]!
    private var cancelledTrips: [Trip]!
    var reloadTableView: (() -> Void)? = nil
    var tripStatus: TripStatus = .completed
    var title: String!
    var completedSegmentTitle: String
    var cancelledSegmentTitle: String

    var numberOfItems: Int {
        switch tripStatus {
        case .canceled:
            return cancelledTrips.count
        case .completed:
            return completedTrips.count
        }
    }
    
    init(trips: [Trip]) {
        self.title = "Trips (\(trips.count))"
        completedTrips = trips.filter { $0.status == .completed}
        cancelledTrips = trips.filter { $0.status == .canceled}
        completedSegmentTitle = "Completed (\(completedTrips.count))"
        cancelledSegmentTitle = "Cancelled (\(cancelledTrips.count))"
    }
    
    func dataForRowAt(index: Int) -> Trip {
        switch tripStatus {
        case .canceled:
            return cancelledTrips[index]
        case .completed:
            return completedTrips[index]
        }
    }
    
    func changeTripStatus(_ status: TripStatus) {
        tripStatus = status
        reloadTableView?()
    }
    
}
