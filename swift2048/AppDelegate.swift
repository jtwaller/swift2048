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
        
        let emptyVc = UIViewController()
        
        window!.rootViewController = emptyVc
        window!.makeKeyAndVisible()
        
        return true
    }

}
