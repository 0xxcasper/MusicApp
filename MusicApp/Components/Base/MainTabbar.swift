//
//  MainTabbar.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class MainTabbar: UITabBarController {
        
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        setUpAppearance()
        setUpViewController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setUpAppearance() {
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.white]
        
//        UITabBar.appearance().clipsToBounds = true
//        UITabBar.appearance().layer.borderWidth = 0
//        tabBar.unselectedItemTintColor = AppColor.color_unselect_tabar
//        tabBar.tintColor = AppColor.color_select_tabar
//        tabBar.barTintColor = .black
        tabBar.isTranslucent = true
    }
    
    func setUpViewController() {
        
        let homeVC = HomeRouter.createModule()
        homeVC.title = "Home"
        let homeNC = BaseNavigationController(rootViewController: homeVC)
        
        let searchVC = SearchRouter.createModule()
        searchVC.title = "Search"
        let searchNC = BaseNavigationController(rootViewController: searchVC)
        searchNC.navigationBar.prefersLargeTitles = true

        let moreVC = MoreRouter.createModule()
        moreVC.title = "More"
        let moreNC = BaseNavigationController(rootViewController: moreVC)
        
        viewControllers = [ homeNC, searchNC, moreNC ]
    }
}

class BaseNavigationController : UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = AppConstant.HEIGTH_TABBAR
        return sizeThatFits
    }
}
