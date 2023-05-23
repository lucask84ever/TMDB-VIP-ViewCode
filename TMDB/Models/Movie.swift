//
//  Movie.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
    }
}
