//
//  Alert.swift
//  Uber
//
//  Created by Elgendy on 5.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

class Alert {
    static func createActionSheet(title: String, message: String? = nil, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        return alert
    }
}
