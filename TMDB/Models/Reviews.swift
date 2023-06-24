//
//  Review.swift
//  TMDB
//
//  Created by Lucas on 18/06/23.
//

import Foundation

struct Reviews: Decodable {
    let results: [UserReview]
}

struct UserReview: Decodable {
    let author: String
    let details: UserDetails
    let content: String
    let updated: String
    
    enum CodingKeys: String, CodingKey {
        case author, content
        case details = "author_details"
        case updated = "updated_at"
    }
}

struct UserDetails: Decodable {
    let name: String?
    let username: String
    let imagePath: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, username, rating
        case imagePath = "avatar_path"
    }
}
