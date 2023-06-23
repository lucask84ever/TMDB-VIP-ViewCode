//
//  ReviewDetailPresenter.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import Foundation

protocol ReviewDetailPresenting {
    var viewController: ReviewDetailViewController? { get set }
    var router: ReviewDetailRouting? { get set }
    var review: UserReview { get set }
    
    func closeViewController()
    
    func setUsername(_ username: String?)
    func setNote(_ note: Double?)
    func setReview(_ review: String)
    func setDateReview(_ date: String?)
    func setAvatarUrl(_ avatarUrl: String?)
}

final class ReviewDetailPresenter: ReviewDetailPresenting {
    var viewController: ReviewDetailViewController? {
        didSet {
            setAvatarUrl(review.details.imagePath)
            setUsername(review.details.username)
            setNote(review.details.rating)
            setReview(review.content)
            setDateReview(review.updated)
        }
    }
    var router: ReviewDetailRouting?
    
    var review: UserReview
    
    init(review: UserReview) {
        self.review = review
    }
    
    func closeViewController() {
        router?.close()
    }
    
    
    func setUsername(_ username: String?){
        viewController?.setUsername(username)
    }
    func setNote(_ note: Double?) {
        if let note = note {
            viewController?.setNote(String(format: "%.1f", note))
        }
    }
    
    func setReview(_ review: String) {
        viewController?.setReview(review)
    }
    
    func setDateReview(_ date: String?) {
        if let updatedAt = date, let updateDate = Date(string: updatedAt, format: .yyyyMMddHHmmssZZZ) {
            let today = Date()
            let formattedString = formatDateToDiff(recentDate: today, pastDate: updateDate)
            viewController?.setDateReview(formattedString)
        }
    }
    
    func setAvatarUrl(_ avatarUrl: String?) {
        viewController?.setAvatarUrl(avatarUrl)
    }
    
    private func formatDateToDiff(recentDate: Date, pastDate: Date) -> String {
        let diff = recentDate - pastDate
        if let year = diff.year, year > 0 {
            return "\(year) year(s) ago"
        }
        
        if let month = diff.month, month > 0 {
            return "\(month) month(s) ago"
        }
        
        if let day = diff.day, day > 0 {
            return "\(day) day(s) ago"
        }
        
        if let hour = diff.hour, hour > 0 {
            return "\(hour) hour(s) ago"
        }
        return "\(diff.minute ?? 0) minute(s) ago"
    }
    
}
