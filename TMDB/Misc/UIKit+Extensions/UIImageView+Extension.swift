//
//  UIImageView+Extension.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import SkeletonView
import UIKit

extension UIImageView {
    func downloadImage(_ imageUrl: ImageEndpoint) {
        showAnimatedSkeleton()
        let session = URLSession.shared
        session.dataTask(with: imageUrl.url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.hideSkeleton()
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
