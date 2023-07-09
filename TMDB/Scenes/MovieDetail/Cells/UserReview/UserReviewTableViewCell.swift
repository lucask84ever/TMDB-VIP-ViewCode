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
    
    internal enum Layout {
        static let avatarImageHeightAndWidth: CGFloat = 44
        static let avatarImageCornerRadius: CGFloat = avatarImageHeightAndWidth/2
        static let marginSpace: CGFloat = 16
        static let labelHeight: CGFloat = 18
        static let baseDistance: CGFloat = 8
        static let halfDistance: CGFloat = baseDistance/2
        static let reviewDefaultHeight: CGFloat = 80
    }
    
    internal enum Constants {
        static let numberOfLines: Int = 4
        static let timeToDissolveShimmer: Double = 0.5
    }
    
    // MARK: View properties
    private lazy var avatarImageLoader: ImageLoader = {
        let imageLoader = ImageLoader()
        imageLoader.isSkeletonable = true
        imageLoader.layer.masksToBounds = true
        imageLoader.layer.cornerRadius = Layout.avatarImageCornerRadius
        return imageLoader
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.font = FontFamily.Poppins.medium.font(size: 12)
        return label
    }()
    
    private lazy var userNote: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.noteColor.color
        label.font = FontFamily.Poppins.medium.font(size: 12)
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textAlignment = .natural
        label.backgroundColor = .clear
        label.numberOfLines = 4
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewLayout()
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
    
    func setupCell(_ review: UserReview) {
        DispatchQueue.main.async { [weak self] in
            self?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.usernameLabel.text = review.details.username
            self?.userNote.text = String(format: "%.1f", review.details.rating ?? 0)
            self?.reviewLabel.text = review.content
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserReviewTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(avatarImageLoader)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userNote)
        contentView.addSubview(reviewLabel)
    }
    
    func buildViewConstraints() {
        avatarImageLoader.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Layout.halfDistance)
            $0.width.height.equalTo(Layout.avatarImageHeightAndWidth)
        }

        userNote.snp.makeConstraints {
            $0.centerX.equalTo(avatarImageLoader)
            $0.height.equalTo(Layout.labelHeight)
            $0.top.equalTo(avatarImageLoader.snp.bottom).offset(Layout.baseDistance)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageLoader)
            $0.leading.equalTo(avatarImageLoader.snp.trailing).offset(Layout.baseDistance)
            $0.trailing.equalToSuperview().inset(Layout.halfDistance)
            $0.height.equalTo(Layout.labelHeight)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(usernameLabel)
            $0.height.equalTo(Layout.reviewDefaultHeight)
            $0.bottom.equalToSuperview().inset(Layout.baseDistance)
        }
    }
    
    func additionalConfig() {
        contentView.backgroundColor = ColorName.backgroundColor.color
    }
}
