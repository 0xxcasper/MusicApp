//
//  AppDelegate.swift
//  Tipbros
//
//  Created by phung on 11/12/19.
//  Copyright © 2019 Vinova. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultMaskType(.clear) // Don't allow user interaction
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeViewController()
        
        
        return true
    }
    
}
