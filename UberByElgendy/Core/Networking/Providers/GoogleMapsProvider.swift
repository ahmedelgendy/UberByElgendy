//
//  GoogleMapsProvider.swift
//  Uber
//
//  Created by Elgendy on 5.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

struct GoogleMapsProvider {
    
    // origin and destination params: "latitude,longitude"
    func getRoutes(origin: String, destination: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        var component = URLComponents(string: "https://maps.googleapis.com/maps/api/directions/json")!
        component.queryItems = [
            URLQueryItem(name: "origin", value: origin),
            URLQueryItem(name: "destination", value: destination),
            URLQueryItem(name: "key", value: AppConstants.googleKey)
        ]
        let task = URLSession.shared.dataTask(with: component.url!) {(data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                completion(.failure(GetRoutesError.noDataFound))
                return
            }
            guard let routes = jsonResult["routes"] as? [Any] else {
                completion(.failure(GetRoutesError.noDataFound))
                return
            }
            guard let route = routes[0] as? [String: Any] else {
                completion(.failure(GetRoutesError.noDataFound))
                return
            }
            guard let overviewPolyline = route["overview_polyline"] as? [String: Any] else {
                completion(.failure(GetRoutesError.noDataFound))
                return
            }
            guard let polyLineString = overviewPolyline["points"] as? String else {
                completion(.failure(GetRoutesError.noDataFound))
                return
            }
            completion(.success(polyLineString))
        }
        task.resume()
    }
    
    enum GetRoutesError: Error {
        case noDataFound
    }
    
}
