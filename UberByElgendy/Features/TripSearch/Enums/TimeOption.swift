//
//  TimeOption.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

enum TimeOption: Int, CaseIterable {
    case any = 0, under5min, between5And10min, between10And20min, moreThan20min
    
    var title: String {
        switch self {
        case .any:
            return "Any"
        case .under5min:
            return "Under 5 min"
        case .between5And10min:
            return "5 to 10 min"
        case .between10And20min:
            return "10 to 20 min"
        case .moreThan20min:
            return "More than 20 min"
        }
    }
}
