//
//  CastCollectionViewCell.swift
//  TMDB
//
//  Created by Lucas on 23/06/23.
//

import SkeletonView
import SnapKit
import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CastCollectionViewCell.self)
    
    internal enum Layout {
        static let cellWidth: CGFloat = UIWindow().bounds.width / 3
        static let cellHeight: CGFloat = cellWidth
        static let margins: CGFloat = 8
        static let labelNameHeight: CGFloat = 18
    }
    
    // MARK: Views
    private lazy var photoImageLoader: ImageLoader = {
        let imageLoader = ImageLoader()
        imageLoader.isSkeletonable = true
        imageLoader.contentMode = .scaleAspectFill
        imageLoader.layer.masksToBounds = true
        imageLoader.skeletonCornerRadius = Float(Layout.cellWidth/2)
        imageLoader.layer.cornerRadius = Layout.cellWidth/2
        imageLoader.showAnimatedGradientSkeleton()
        return imageLoader
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Poppins.medium.font(size: 12)
        label.textColor = .white
        label.isSkeletonable = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.showAnimatedGradientSkeleton()
        return label
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

extension CastCollectionViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(photoImageLoader)
        
        contentView.addSubview(nameLabel)
    }
    
    func buildViewConstraints() {
        photoImageLoader.snp.makeConstraints {
            $0.width.height.equalTo(Layout.cellWidth)
            $0.top.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.bottom.equalToSuperview().inset(8)
            $0.top.equalTo(photoImageLoader.snp.bottom)
            $0.height.equalTo(36)
            $0.width.greaterThanOrEqualTo(Layout.cellWidth)
        }
    }
    
    func additionalConfig() {
        clipsToBounds = true
        photoImageLoader.clipsToBounds = true
        photoImageLoader.showAnimatedGradientSkeleton()
        nameLabel.showAnimatedGradientSkeleton()
        photoImageLoader.layer.cornerRadius = photoImageLoader.frame.width/2
    }
}

extension CastCollectionViewCell {
    func setName(_ name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.nameLabel.text = name
        }
        
    }
    
    func setPhotoPath(_ urlPath: String) {
        DispatchQueue.main.async { [weak self] in
            let imageEndpoint = ImageEndpoint(path: urlPath)
            self?.photoImageLoader.getImage(imageEndpoint)
        }
    }
}
