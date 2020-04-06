
//
//  BaseViewController.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

enum NavigationStyle {
    case left
    case right
}

class BaseViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .ChangeLanguage, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ChangeRegion, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        addKeyboardNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.view.setGradient(startColor: UIColor(displayP3Red: 100/255, green: 50/255, blue: 194/255, alpha: 1), secondColor: UIColor(displayP3Red: 62/255, green: 17/255, blue: 145/255, alpha: 1))
        }
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeLanguage(notification:)), name: .ChangeLanguage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeRegion(notification:)), name: .ChangeRegion, object: nil)
    }
    
    @objc func didChangeLanguage(notification: Notification) {
        self.didChangeLanguage()
    }
    
    @objc func didChangeRegion(notification: Notification) {
        self.didChangeRegion()
    }
    
    @objc func pullToRefreshData() {
        
    }
    
    func didChangeLanguage() {
        
    }
    
    func didChangeRegion() {
        
    }
    
    func setUpNavigation() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(named: "IMG_6722"), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }

    func showLargeTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
    @objc func backButtonTapped() {
        self.pop()
    }
    
    func hideTabbar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabbar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: For Navigation
extension BaseViewController {

    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        controller.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(controller, animated: animated)
    }

    func pop(animated: Bool = true ) {
        self.navigationController?.popViewController(animated: animated)
    }

    func present(controller: UIViewController, animated: Bool = true) {
        self.present(controller, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool = true) {
        self.dismiss(animated: animated, completion: nil)
    }
    
}

extension BaseViewController {
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("")
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
    }
}
