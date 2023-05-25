//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import UIKit

protocol DetailMovieDisplaying {
    func setMovieTitle(_ title: String)
    func setMovieDescription(_ description: String)
    func setMovieData(_ releaseDate: String)
    func fetchMovieTrailer()
}

class DetailMovieViewController: BaseViewController<DetailMovieInteracting, DetailMovieView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .white
    }
}

// MARK: - Displaying protocol
extension DetailMovieViewController: DetailMovieDisplaying {
    func fetchMovieTrailer() {
        
    }
    
    func setMovieTitle(_ title: String) {
        
    }
    
    func setMovieDescription(_ description: String) {
        
    }
    
    func setMovieData(_ releaseDate: String) {
        
    }
}
