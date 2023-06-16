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
        
        guard #available(iOS 13, *) else {
            return true
        }
        let navigationController = TMDB.initialSetup()
        navigationController.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

