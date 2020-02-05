//
//  Environment.swift
//  Uber
//
//  Created by Elgendy on 6.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

public enum Environment {
    case prod
    case dev
    case custom(url: String, port: Int)

    var baseURL: String {
        switch self {
        case .prod:
            return "elgendy.dev"
        case .dev:
            return "elgendy.prod"
        case .custom(let url, _):
            return url
        }
    }
    
    var scheme: String {
        switch self {
        case .prod, .dev:
            return "https"
        default:
            return "http"
        }
    }
    
    var port: Int? {
        switch self {
        case .custom(_, let port):
            return port
        default:
            return nil
        }
    }
}



