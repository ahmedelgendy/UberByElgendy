//
//  Searchable.swift
//  Uber
//
//  Created by Elgendy on 5.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

protocol Searchable {
    func matches(query: String) -> Bool
}

extension String: Searchable {
    func matches(query: String) -> Bool {
        return self.lowercased().contains(query.lowercased())
    }
}

extension Int: Searchable {
    func matches(query: String) -> Bool {
        return String(self).matches(query: query)
    }
}

extension Double: Searchable {
    func matches(query: String) -> Bool {
        return String(self).matches(query: query)
    }
}
