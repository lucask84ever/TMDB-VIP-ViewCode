//
//  VideosResponse.swift
//  TMDB
//
//  Created by Lucas Lima on 01/06/23.
//

import Foundation

struct VideosResponse: Decodable {
    var videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case videos = "results"
    }
}

struct Video: Decodable {
    var language: String
    var country: String
    var name: String
    var site: String
    var urlEnd: String
    
    enum CodingKeys: String, CodingKey {
        case language = "iso_639_1"
        case country = "iso_3166_1"
        case name
        case site
        case urlEnd = "key"
    }
    
    var idiom: String {
        return String("\(language)-\(country)")
    }
}
