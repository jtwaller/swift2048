//
//  AppDelegate.swift
//  swift2048
//
//  Created by jack on 9/21/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let gameVc = storyboard.instantiateViewController(withIdentifier: "HomeScreen")

        let navController = UINavigationController(rootViewController: gameVc)
        navController.setNavigationBarHidden(true, animated: false)

        window!.rootViewController = navController
        window!.makeKeyAndVisible()

        return true
    }
}
