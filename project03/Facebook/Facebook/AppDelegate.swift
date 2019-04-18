//
//  AppDelegate.swift
//  Facebook
//
//  Created by Seoyoung on 11/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: FBViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

