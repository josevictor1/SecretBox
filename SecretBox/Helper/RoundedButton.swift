//
//  RoundedButton.swift
//  SecretBox
//
//  Created by José Victor Pereira Costa on 14/06/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    // MARK: - Drawing Function
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear
    @IBInspectable open var borderWidth: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.size.height/2
        layer.masksToBounds = false
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
