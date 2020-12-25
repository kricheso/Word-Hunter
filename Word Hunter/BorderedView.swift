//
//  BorderedView.swift
//  Word Hunter
//
//  Created by Kousei Richeson on 12/24/20.
//

import UIKit

@IBDesignable

class BorderedView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = CGFloat.zero {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > CGFloat.zero
        }
        get {
            return layer.cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
