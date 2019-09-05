//
//  UIView+RoundedCorners.swift
//  NimbleExtension
//
//  Created by Jason Nam on 5/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import UIKit

public extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
