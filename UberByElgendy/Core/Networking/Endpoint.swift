//
//  Endpoint.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

public protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

public enum Endpoint {
    case tripSearch
}

extension Endpoint: RequestProviding {
    
    public var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = AppContext.environment.scheme
        urlComponents.host = AppContext.environment.baseURL
        urlComponents.port = AppContext.environment.port
        switch self {
        case .tripSearch:
            urlComponents.path = "/trips/recent.json"
            return URLRequest(url: urlComponents.url!)
        }
    }
}
