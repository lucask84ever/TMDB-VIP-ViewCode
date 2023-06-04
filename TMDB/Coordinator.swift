//
//  TMDB.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

protocol Coordinating {
    static func initialSetup() -> UITabBarController
    func showDetailMovie(_ movie: Movie)
}

class Coordinator: Coordinating {
    static func initialSetup() -> UITabBarController {
        let tabbar = UITabBarController()
        let navigationController = UINavigationController()
        tabbar.setViewControllers([navigationController, UIViewController()], animated: true)
        let upcomingMoviesViewController = UpcomingMoviesFactory.make()
        navigationController.pushViewController(upcomingMoviesViewController,
                                                animated: true)
        return tabbar
    }
    
    func showDetailMovie(_ movie: Movie) {
        
    }
}
