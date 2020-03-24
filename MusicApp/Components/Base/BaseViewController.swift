
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setUpNavigation() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
//        navigationController.view.backgroundColor = backgroundColor
//        navigationController.navigationBar.backgroundColor = backgroundColor
//        navigationController.navigationBar.barTintColor = backgroundColor
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
        showNavigation()
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
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
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
    }
}
