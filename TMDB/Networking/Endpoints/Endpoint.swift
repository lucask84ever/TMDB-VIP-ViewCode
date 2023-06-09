//
//  Endpoint.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: "1f54bd990f1cdfb230adb312546d765d"),
                                      URLQueryItem(name: "language", value: "pt-BR")]
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("invalid URL components \(components)")
        }
        return url
    }
}

extension Endpoint {
    static var upcomingMovies: Self {
        Endpoint(path: "movie/upcoming")
    }
    
    static var topRatedMovies: Self {
        Endpoint(path: "movie/top_rated")
    }
    
    static var popularMovies: Self {
        Endpoint(path: "movie/popular")
    }
    
    static var nowPlayingMovies: Self {
        Endpoint(path: "movie/now_playing")
    }
    
    static func trailers(_ id: Int) -> Self {
        Endpoint(path: "movie/\(id)/videos")
    }
    
    static func movieDetail(_ id: Int) -> Self {
        Endpoint(path: "movie/\(id)/")
    }
}
