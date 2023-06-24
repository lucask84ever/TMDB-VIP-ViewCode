//
//  ImageEndpoint.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

struct ImageEndpoint {
    var path: String
}

extension ImageEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = PlistFiles.scheme
        components.host = PlistFiles.imageHost
        components.path = PlistFiles.imagePath + path
        guard let url = components.url else {
            preconditionFailure("invalid URL components \(components)")
        }
        return url
    }
    
    static func getImageUrl(_ path: String) -> Self {
        ImageEndpoint(path: path)
    }
}
