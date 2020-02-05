//
//  Distance.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

enum DistanceOption: Int, CaseIterable {
    case any = 0, under3km = 1, between3And8km = 2, between8And15km = 3, moreThan15km = 4
    
    var title: String {
        switch self {
        case .any:
            return "Any"
        case .under3km:
            return "Under 3 km"
        case .between3And8km:
            return "3 to 8 km"
        case .between8And15km:
            return "8 to 15 km"
        case .moreThan15km:
            return "More than 15 km"
        }
    }
}
