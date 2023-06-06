//
//  HomeView.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import SnapKit
import UIKit

final class HomeView: UIView {
    
    internal enum LayoutConstants {
        static let labelHeight: CGFloat = 28
        static let textfieldHeight: CGFloat = 48
        static let distanceLabelTextfield: CGFloat = 16
    }
    
    lazy var wantToWatchLabel: UILabel = {
        let label = UILabel()
        label.text = TMDBStrings.Home.Label.wantToWatch
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    lazy var searchMovieTextfield: CustomTextfield = {
        let textfield = CustomTextfield()
        let lensImage = UIImageView(image: UIImage(named: "search"))
        textfield.layer.cornerRadius = 16
        lensImage.tintColor = ColorName.textfieldTextIcon.color
        textfield.textColor = ColorName.textfieldTextIcon.color
        let attributedPlaceholder = NSAttributedString(string: TMDBStrings.Home.Textfield.searchPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.textfieldTextIcon.color])
        textfield.attributedPlaceholder = attributedPlaceholder
        textfield.backgroundColor = ColorName.textfieldBackground.color
        textfield.leftView = UIView()
        textfield.leftViewMode = .always
        textfield.rightView = lensImage
        textfield.rightViewMode = .always
        return textfield
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
}

extension HomeView: ViewcodeProtocol {
    func buildViewHierarchy() {
        addSubview(wantToWatchLabel)
        addSubview(searchMovieTextfield)
    }
    
    func buildViewConstraints() {
        wantToWatchLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(LayoutConstants.labelHeight)
        }
        
        searchMovieTextfield.snp.makeConstraints {
            $0.leading.trailing.equalTo(wantToWatchLabel)
            $0.height.equalTo(LayoutConstants.textfieldHeight)
            $0.top.equalTo(wantToWatchLabel.snp.bottom).offset(LayoutConstants.distanceLabelTextfield)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(touchOutside))
        self.addGestureRecognizer(tapOutside)
    }
    
    @objc
    private func touchOutside() {
        endEditing(true)
    }
}
