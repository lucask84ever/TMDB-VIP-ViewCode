//
//  Genre.swift
//  TMDB
//
//  Created by Lucas Lima on 01/06/23.
//

import Foundation

struct ListGenres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
