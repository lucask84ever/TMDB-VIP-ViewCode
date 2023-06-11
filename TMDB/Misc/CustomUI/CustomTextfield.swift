//
//  CustomTextfield.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

final class CustomTextfield: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 10)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textfieldRect = super.rightViewRect(forBounds: bounds)
        textfieldRect.origin.x -= 16
        return textfieldRect
    }
}
