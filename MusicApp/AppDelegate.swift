//
//  AppDelegate.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultMaskType(.clear) // Don't allow user interaction
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setUpAppLanguage()
        setUpRegionCode()
        
        window?.rootViewController = MainTabbar()
        window?.setGradient(startColor: UIColor(displayP3Red: 133/255, green: 24/255, blue: 229/255, alpha: 1),
                            secondColor: UIColor(displayP3Red: 93/255, green: 153/255, blue: 238/255, alpha: 1))
        
        return true
    }
    
    func setUpAppLanguage() {
        if let currentLanguage = LanguageType(rawValue: LanguageHelper.currentAppleLanguage()) {
            LanguageHelper.setAppleLAnguageTo(lang: currentLanguage)
        } else {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        }
    }
    
    func setUpRegionCode() {
        if UserDefaultHelper.shared.regionCode == nil {
            UserDefaultHelper.shared.regionCode = "VN"
        }
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        return true
    }
}
