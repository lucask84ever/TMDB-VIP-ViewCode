//
//  Endpoint.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: PlistFiles.apiKey)]
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = PlistFiles.scheme
        components.host = PlistFiles.host
        components.path = PlistFiles.path + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("invalid URL components \(components)")
        }
        return url
    }
}

extension Endpoint {
    static var upcomingMovies: Self {
        Endpoint(path: PlistFiles.upcoming)
    }
    
    static var topRatedMovies: Self {
        Endpoint(path: PlistFiles.topRated)
    }
    
    static var popularMovies: Self {
        Endpoint(path: PlistFiles.popular)
    }
    
    static var nowPlayingMovies: Self {
        Endpoint(path: PlistFiles.playingNow)
    }
    
    static func trailers(_ id: Int) -> Self {
        let url = PlistFiles.trailers.replacingOccurrences(of: "{id}", with: id.description)
        return Endpoint(path: url)
    }
    
    static func casting(_ id: Int) -> Self {
        let url = PlistFiles.cast.replacingOccurrences(of: "{id}", with: id.description)
        return Endpoint(path: url)
    }
    
    static func revies(_ id: Int) -> Self {
        let url = PlistFiles.reviews.replacingOccurrences(of: "{id}", with: id.description)
        return Endpoint(path: url)
    }
    
    static func movieDetail(_ id: Int) -> Self {
        let url = PlistFiles.detail.replacingOccurrences(of: "{id}", with: id.description)
        return Endpoint(path: url)
    }
}
