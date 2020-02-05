//
//  AppTheme.swift
//  Uber
//
//  Created by Elgendy on 4.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

/// Apply application theme and colors
class AppTheme {
    
    static func apply() {
        navigationBarStyle()
        searchBarStyle()
    }
    
    private static func navigationBarStyle() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        UINavigationBar.appearance().isTranslucent = false
    }

    private static  func searchBarStyle() {
        let searchTextField = UITextField.appearance(
            whenContainedInInstancesOf: ([UISearchBar.self])
        )
        searchTextField.backgroundColor = .white
    }
}
