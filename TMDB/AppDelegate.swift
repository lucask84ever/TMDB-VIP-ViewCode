//
//  AppDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #unavailable(iOS 13) {
            let navigation = UINavigationController()
            let upcomingMoviesViewController = UpcomingMoviesFactory.make()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigation
            navigation.pushViewController(upcomingMoviesViewController, animated: true)
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    
}

