//
//  TMDB.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

final class TMDB {
    static func initialSetup() -> UINavigationController {
        let tabbar = UITabBarController()
        setupTabBar(tabbar.tabBar)
        let navigationController = UINavigationController()
        let homeViewController = HomeFactory.make()
        
        homeViewController.title = TMDBStrings.Tabbar.home
        
        
        let searchViewController = SearchMovieFactory.make()
        
        searchViewController.title = TMDBStrings.Tabbar.search
        
        let watchListViewController = WatchListFactory.make()
        
        watchListViewController.title = TMDBStrings.Tabbar.watchList
        
        navigationController.pushViewController(homeViewController,
                                                animated: true)
        tabbar.setViewControllers([homeViewController, searchViewController, watchListViewController], animated: true)
        homeViewController.tabBarController?.tabBar.items?[0].image = UIImage(named: "home")
        searchViewController.tabBarController?.tabBar.items?[1].image = UIImage(named: "search")
        searchViewController.tabBarController?.tabBar.items?[2].image = UIImage(named: "mark")
        return UINavigationController(rootViewController: tabbar)
    }
    
    private static func setupTabBar(_ tabbar: UITabBar?) {
        tabbar?.barTintColor = ColorName.backgroundColor.color
        tabbar?.tintColor = ColorName.tabBarLine.color
        let line = UIView(frame: CGRect(x: 0, y: 0, width: tabbar?.frame.width ?? 0.0, height: 1))
        line.backgroundColor = ColorName.tabBarLine.color
        tabbar?.addSubview(line)
    }
}
