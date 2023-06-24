//
//  ReviewDetailViewController.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import UIKit

protocol ReviewDetailDisplaying {
    func setUsername(_ username: String?)
    func setAvatarUrl(_ avatarPath: String?)
    func setNote(_ note: String)
    func setReview(_ review: String)
    func setDateReview(_ dateReview: String)
}

class ReviewDetailViewController: BaseViewController<ReviewDetailInteracting, ReviewDetailView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClosure()
    }
    
    private func setupClosure() {
        rootView.touchBack = { [weak self] in
            self?.interactor.back()
        }
    }
}

extension ReviewDetailViewController: ReviewDetailDisplaying {
    func setUsername(_ username: String?) {
        rootView.setUsername(username)
    }
    
    func setAvatarUrl(_ avatarPath: String?) {
        rootView.setAvatarUrl(avatarPath)
    }
    
    func setNote(_ note: String) {
        rootView.setNote(note)
    }
    
    func setReview(_ review: String) {
        rootView.setReview(review)
    }
    
    func setDateReview(_ dateReview: String) {
        rootView.setDateReview(dateReview)
    }
}
