//
//  CustomTextfield.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

final class CustomTextfield: UITextField {
    
    var searchAction: ((String) -> Void)?
    
    internal enum Constants {
        static let dx: CGFloat = 16
        static let dy: CGFloat = 10
        static let xOrigin: CGFloat = -16
        static let cornerRadius: CGFloat = 16
    }
    
    func setupSearch() {
        setupAccessoryImage("lens")
        layer.cornerRadius = Constants.cornerRadius
        textColor = ColorName.textColor.color
        let _attributedPlaceholder = NSAttributedString(string: TMDBStrings.Search.Textfield.searchPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: ColorName.textfieldTextIcon.color])
        attributedPlaceholder = _attributedPlaceholder
        backgroundColor = ColorName.textfieldBackground.color
        leftView = UIView()
        leftViewMode = .always
    }
    
    private func setupAccessoryImage(_ imageName: String) {
        if let image = UIImage(named: imageName) {
            let lensImage = UIImageView(image: image)
            lensImage.tintColor = ColorName.textfieldTextIcon.color
            lensImage.transform = CGAffineTransform(scaleX: -1, y: 1)
            rightView = lensImage
            rightViewMode = .always
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constants.dx, dy: Constants.dy)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constants.dx, dy: Constants.dy)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textfieldRect = super.rightViewRect(forBounds: bounds)
        textfieldRect.origin.x += Constants.xOrigin
        return textfieldRect
    }
    
    @objc
    private func lensAction() {
        print("BUSCANDO")
        if let text = text, !text.isEmpty {
            searchAction?(text)
        }
    }
}
