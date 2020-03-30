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
    
    let playBar = PlayMusicBar()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .OpenPlayBar, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didOpenPlayBar(notification:)), name: .OpenPlayBar, object: nil)
        setUpView()
        setUpAppearance()
        setUpViewController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        playBar.frame = CGRect(x: -AppConstant.SREEEN_WIDTH, y: tabBar.frame.origin.y - 48, width: AppConstant.SREEEN_WIDTH, height: 48)
    }
    
    @objc func didOpenPlayBar(notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            playBar.items = data["items"] as! [Any]
            playBar.type = data["type"] as! PlaylistType
            playBar.currentIndex = data["currentIndex"] as! Int
            playBar.animateLeftToRight()
        }
    }
    
    func setUpView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.view.addSubview(playBar)
    }
    
    func setUpAppearance() {
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.white]
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .white
        tabBar.setGradient(startColor: UIColor(displayP3Red: 83/255, green: 54/255, blue: 239/255, alpha: 1),
                           secondColor: UIColor(displayP3Red: 83/255, green: 113/255, blue: 108/255, alpha: 1))
        tabBar.isTranslucent = true
    }
    
    func setUpViewController() {
        
        let homeVC = HomeRouter.createModule()
        homeVC.title = LocalizableKey.playList.localizeLanguage
        let homeNC = BaseNavigationController(rootViewController: homeVC)
        homeNC.navigationBar.prefersLargeTitles = true
        
        let searchVC = SearchRouter.createModule()
        searchVC.title = LocalizableKey.search.localizeLanguage
        let searchNC = BaseNavigationController(rootViewController: searchVC)
        searchNC.navigationBar.prefersLargeTitles = true

        let moreVC = MoreRouter.createModule()
        moreVC.title = LocalizableKey.more.localizeLanguage
        let moreNC = BaseNavigationController(rootViewController: moreVC)
        moreNC.navigationBar.prefersLargeTitles = true
        
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
        self.navigationBar.tintColor = .white
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
