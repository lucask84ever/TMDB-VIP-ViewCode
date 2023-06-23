//
//  ReviewDetailView.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import SkeletonView
import SnapKit
import UIKit

final class ReviewDetailView: UIView {
    
    // MARK: Closure
    var touchBack: (() -> Void)?
    
    // MARK: UIElements
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(touchCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarImageLoader: ImageLoader = {
        let image = ImageLoader()
        image.isSkeletonable = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.font = FontFamily.Poppins.bold.font(size: 14)
        return label
    }()
    
    private lazy var reviewDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.subtitleColor.color
        label.font = FontFamily.Poppins.regular.font(size: 14)
        return label
    }()
    
    private lazy var noteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.backgroundColorWithAlpha.color
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.font = FontFamily.Poppins.semiBold.font(size: 14)
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = ColorName.textColor.color
        textView.font = FontFamily.Poppins.regular.font(size: 14)
        textView.textAlignment = .justified
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = ColorName.backgroundColor.color
        return textView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewDetailView {
    @objc
    private func touchCloseButton() {
        touchBack?()
    }
}

extension ReviewDetailView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(reviewDateLabel)
        contentView.addSubview(avatarImageLoader)
        contentView.addSubview(noteBackgroundView)
        contentView.addSubview(reviewTextView)
        noteBackgroundView.addSubview(noteLabel)
        noteBackgroundView.addSubview(starImageView)
        
    }
    
    func buildViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.width.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        avatarImageLoader.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(8)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageLoader.snp.trailing).offset(16)
            $0.height.equalTo(18)
            $0.bottom.equalTo(avatarImageLoader.snp.centerY)
        }
        
        reviewDateLabel.snp.makeConstraints {
            $0.leading.height.equalTo(usernameLabel)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
        
        noteBackgroundView.snp.makeConstraints {
            $0.trailing.equalTo(closeButton.snp.leading).offset(-8)
            $0.height.equalTo(24)
            $0.centerY.equalTo(usernameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(noteLabel.snp.left).offset(-8)
            $0.height.width.equalTo(14)
        }
        
        noteLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
            $0.height.equalTo(18)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(avatarImageLoader.snp.bottom).offset(16)
            $0.leading.equalTo(avatarImageLoader)
            $0.trailing.equalTo(closeButton)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}

extension ReviewDetailView {
    func setUsername(_ username: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.usernameLabel.text = username
        }
    }
    
    func setAvatarUrl(_ avatarUrl: String?) {
        guard let imagePath = avatarUrl else {
            avatarImageLoader.image = UIImage(named: "userplaceholder")
            return
        }
        
        if imagePath.contains("https") {
            let formatted = imagePath.replacingOccurrences(of: "/https", with: "https")
            avatarImageLoader.getImage(formatted)
        } else {
            let imageEndpoint = ImageEndpoint(path: imagePath)
            avatarImageLoader.getImage(imageEndpoint)
        }
    }
    
    func setNote(_ note: String) {
        noteLabel.text = note
    }
    
    func setReview(_ review: String) {
        reviewTextView.text = review
    }
    
    func setDateReview(_ dateReview: String) {
        reviewDateLabel.text = dateReview
    }
}
