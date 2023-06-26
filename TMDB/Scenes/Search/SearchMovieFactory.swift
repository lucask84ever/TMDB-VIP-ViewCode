//
//  SearchMovieFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

class SearchMovieFactory {
    static func make() -> SearchMovieViewController {
        let router = SearchMovieRouter(navigationController: UIApplication.shared.inputViewController?.navigationController)
        let presenter = SearchMoviePresenter()
        let service = SearchMovieService()
        let interactor = SearchMovieInteractor(presenter: presenter, service: service)
        let viewController = SearchMovieViewController(interactor: interactor)
        
        presenter.router = router
        presenter.viewController = viewController
        viewController.title = TMDBStrings.Tabbar.search
        viewController.tabBarController?.tabBar.items?[1].image = UIImage(named: "search")
        return viewController
    }
}
