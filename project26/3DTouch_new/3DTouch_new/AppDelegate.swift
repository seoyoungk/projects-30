//
//  AppDelegate.swift
//  3DTouch_new
//
//  Created by Seoyoung on 20/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

enum Shortcut: String {
    case openBlue = "OpenBlue"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions called")
        var isLaunchedFromQuickAction = false
        
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            isLaunchedFromQuickAction = true
            handleQuickAction(shortcutItem: shortcutItem)
        } else {
            self.window?.backgroundColor = UIColor.white
        }
        return !isLaunchedFromQuickAction
    }

    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var quickActionHandled = false
        let type = shortcutItem.type.components(separatedBy: ".").last!
        if let shortcutType = Shortcut.init(rawValue: type) {
            switch shortcutType {
            case .openBlue:
                self.window?.backgroundColor = UIColor(red: 151.0/255.0, green: 187.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                quickActionHandled = true
            }
        }
        return quickActionHandled
    }

}

