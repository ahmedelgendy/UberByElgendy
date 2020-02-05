//
//  AppStarter.swift
//  Uber
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps

/// AppStarter here you can handle everything before letting your app starts
final class AppStarter {
    static let shared = AppStarter()
    
    private init() {}
    
    func start(window: UIWindow?) {
        AppContext.setupAppEnvironment()
        setupKeyboardConfig()
        setupGoogleMaps()
        AppTheme.apply()
        setRootViewController(window: window)
    }
    
    private func setupKeyboardConfig() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private func setRootViewController(window: UIWindow?) {
        let provider = TripsProvider(network: Networking())
        let viewModel = TripSearchViewModel(provider: provider)
        let tripSearchViewController = TripSearchViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: tripSearchViewController)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

extension AppStarter {
    fileprivate func setupGoogleMaps() {
        GMSServices.provideAPIKey(AppConstants.googleKey)
    }
}
