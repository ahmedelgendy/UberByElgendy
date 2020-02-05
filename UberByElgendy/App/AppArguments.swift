//
//  AppArguments.swift
//  Uber
//
//  Created by Elgendy on 6.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

struct AppArgument {
    static func runForUnitTesting() -> Bool {
        return CommandLine.arguments.contains("-unittesting")
    }
    static func runForUITesting() -> Bool {
        return CommandLine.arguments.contains("-uitesting")
    }
}
