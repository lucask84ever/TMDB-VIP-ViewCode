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
            let tabbar = TMDB.initialSetup()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = tabbar
            window?.makeKeyAndVisible()
        }
        return true
    }
}

