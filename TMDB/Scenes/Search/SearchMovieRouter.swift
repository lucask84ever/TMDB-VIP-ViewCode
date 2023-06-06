//
//  SearchMovieRouter.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

protocol SearchMovieRouting {
    var navigationController: UINavigationController? { get set }
}

final class SearchMovieRouter: SearchMovieRouting {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
