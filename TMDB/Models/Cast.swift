//
//  Cast.swift
//  TMDB
//
//  Created by Lucas on 23/06/23.
//

import Foundation

struct Cast: Decodable {
    let name: String
    let imagePath: String?
    let department: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case name , popularity
        case imagePath = "profile_path"
        case department = "known_for_department"
    }
}

struct Casting: Decodable {
    let cast: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case cast
    }
    
    func filterCast(_ castType: String) -> [Cast] {
        return cast.filter({ $0.department == castType }).sorted(by: { $0.popularity >= $1.popularity })
    }
}
