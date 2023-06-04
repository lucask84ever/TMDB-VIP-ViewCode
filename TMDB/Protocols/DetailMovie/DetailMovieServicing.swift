//
//  DetailMovieServicing.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation
typealias TrailerResult = (Result<VideosResponse, Error>) -> Void
typealias MovieDetailsResult = (Result<DetailedMovie, Error>) -> Void

protocol DetailMovieServicing {
    func fetchMovieTrailer(_ movieId: Int, completion: @escaping TrailerResult)
    
    func fetchMovieDetails(_ movieId: Int, completion: @escaping MovieDetailsResult)
}
