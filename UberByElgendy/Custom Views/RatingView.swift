//
//  RatingView.swift
//  Uber
//
//  Created by Elgendy on 4.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

class RatingView: UIStackView {
    
    let fullStar = UIImage(named: "full-star")
    let emptyStar = UIImage(named: "empty-star")
    
    func rate(_ rate: Int) {
        resetRating()
        guard rate != 0 else {
            return }
        for index in 0..<rate {
            let imageView = self.subviews[index] as? UIImageView
            imageView?.image = fullStar
        }
    }
    
    private func resetRating() {
        self.subviews.forEach { (view) in
            if let imageView = view as? UIImageView {
                imageView.image = emptyStar
            }
        }
    }
    
}
