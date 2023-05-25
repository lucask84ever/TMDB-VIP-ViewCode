//
//  Movie.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
    let numberOfPages: Int
    let currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case numberOfPages = "total_pages"
        case currentPage = "page"
    }
}

struct Movie: Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genres: [Int]
    let averageNote: Double
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case name = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres = "genre_ids"
        case averageNote = "vote_average"
    }
}

struct ListGenres {
    let genres: [Genre]
}

struct Genre {
    let id: Int
}
