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
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.size.height/2
        layer.masksToBounds = false
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    func updateButtonOnClick(newTitle: String = "", textColor: UIColor, backGroundColor: UIColor) {

        let textTitle = newTitle != "" ? newTitle : titleLabel!.text
        setTitle(textTitle, for: .normal)
        setTitleColor(textColor, for: .normal)
        backgroundColor = backGroundColor
    }
}
