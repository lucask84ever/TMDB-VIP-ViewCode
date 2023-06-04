//
//  MovieResponse.swift
//  TMDB
//
//  Created by Lucas Lima on 01/06/23.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
    let numberOfPages: Int
    let currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case numberOfPages = "total_pages"
        case currentPage = "page"
    }
}
