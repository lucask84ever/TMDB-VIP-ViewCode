//
//  HomeFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation
import UIKit

class HomeFactory {
    static func make() -> HomeViewController {
        let service = HomeService()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(servicing: service, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        
        viewController.title = TMDBStrings.Tabbar.home
        viewController.tabBarController?.tabBar.items?[0].image = UIImage(named: "home")
        let router = HomeRouter()
        
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
