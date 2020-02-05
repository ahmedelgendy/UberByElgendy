//
//  UIView-shadows.swift
//  Uber
//
//  Created by Elgendy on 4.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(shadowColor: UIColor = .lightGray,
                   offSet: CGSize = CGSize(width: 0, height: 0),
                   opacity: Float = 0.3,
                   shadowRadius: CGFloat = 5,
                   cornerRadius: CGFloat = 10,
                   corners: UIRectCorner = [[.topRight, .topLeft, .bottomLeft, .bottomRight]],
                   fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds,
                                  byRoundingCorners: corners,
                                  cornerRadii: size).cgPath
        shadowLayer.path = cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
        backgroundColor = .clear
    }
}
