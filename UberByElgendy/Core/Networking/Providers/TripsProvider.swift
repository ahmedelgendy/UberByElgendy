//
//  TripSearchProvider.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

protocol TripsProviding {
    var network: Networking { get }
    func tripSearch(_ completion: @escaping (Result<TripSearchResponse, Error>) -> Void)
}

struct TripsProvider: TripsProviding {
    
    let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func tripSearch(_ completion: @escaping (Result<TripSearchResponse, Error>) -> Void) {
        let endpoint = Endpoint.tripSearch
        network.execute(endpoint, completion: completion)
    }
}
