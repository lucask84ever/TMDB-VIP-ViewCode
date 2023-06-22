//
//  UserReviewTableViewCell.swift
//  TMDB
//
//  Created by Lucas on 19/06/23.
//

import SkeletonView
import SnapKit
import UIKit

class UserReviewTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: UserReviewTableViewCell.self)
    
    // MARK: View properties
    private lazy var avatarImageLoader: ImageLoader = {
        let imageLoader = ImageLoader()
        imageLoader.isSkeletonable = true
        imageLoader.layer.masksToBounds = true
        imageLoader.layer.cornerRadius = 22
        return imageLoader
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var userNote: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var reviewTextview: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.textAlignment = .natural
        label.backgroundColor = .clear
        label.numberOfLines = 4
//        textview.isScrollEnabled = false
//        textview.isEditable = false
        return label
    }()
    
//    private lazy var reviewTextview: UILabel = {
//        let textview = UILabel()
//        textview.textColor = ColorName.textColor.color
//        textview.numberOfLines = 0
//        textview.lineBreakMode = .byWordWrapping
//        textview.backgroundColor = .clear
//        return textview
//    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageLoader.image = nil
    }
    
    func expandCell() {
//        reviewTextview.numberOfLines = 0
//        setupExpandedCell()
    }
    
    func contractCell() {
//        reviewTextview.numberOfLines = 3
//        setupDefaultCell()
    }
    
    func setupCell(_ review: UserReview) {
        DispatchQueue.main.async { [weak self] in
            self?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.usernameLabel.text = review.details.username
            self?.userNote.text = String(format: "%.1f", review.details.rating ?? 0)
            self?.reviewTextview.text = review.content
//            self?.reviewTextview.textContainer.heightTracksTextView = true
            self?.buildViewConstraints()
        }
        
        guard let imagePath = review.details.imagePath else {
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
    
    // MARK: Custom methods
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserReviewTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(avatarImageLoader)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userNote)
        contentView.addSubview(reviewTextview)
    }
    
    func buildViewConstraints() {
        avatarImageLoader.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(4)
            $0.width.height.equalTo(44)
        }

        userNote.snp.makeConstraints {
            $0.centerX.equalTo(avatarImageLoader)
            $0.height.equalTo(18)
            $0.top.equalTo(avatarImageLoader.snp.bottom).offset(8)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageLoader)
            $0.leading.equalTo(avatarImageLoader.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(18)
        }
        
        reviewTextview.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(usernameLabel)
            $0.height.equalTo(80)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func additionalConfig() {
        contentView.backgroundColor = ColorName.backgroundColor.color
    }
}
