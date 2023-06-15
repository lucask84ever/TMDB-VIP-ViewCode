//
//  Movie.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genres: [Int]
    let averageNote: Double
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case name = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres = "genre_ids"
        case averageNote = "vote_average"
        case backdropPath = "backdrop_path"
    }
}

struct DetailedMovie: Decodable {
//    let id: Int
    let name: String
//    let overview: String
//    let duration: Int
//    let note: Double
    
    enum CodingKeys: String, CodingKey {
//        case id, overview
        case name = "title"
//        case duration = "runtime"
//        case note = "vote_average"
    }
}
