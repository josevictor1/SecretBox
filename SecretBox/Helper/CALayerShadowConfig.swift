//
//  CALayerShadowConfig.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 15/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension CALayer {
    
    /// apply a ScketchShadow on the view
    ///
    /// - Parameters:
    ///   - color: shadow color
    ///   - alpha: shadow alpha
    ///   - x: shadow x point cordinate
    ///   - y: shadow y point cordinate
    ///   - blur: shadow blur
    ///   - spread: shadow spread
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
}
