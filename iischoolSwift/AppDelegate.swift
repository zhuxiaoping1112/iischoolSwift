//
//  AppDelegate.swift
//  iischoolSwift
//
//  Created by junke on 2018/12/14.
//  Copyright © 2018 hank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let ifbaseNav = IFBaseNavController(rootViewController: UIViewController());
        window?.rootViewController = ifbaseNav;
        return true
    }
}

