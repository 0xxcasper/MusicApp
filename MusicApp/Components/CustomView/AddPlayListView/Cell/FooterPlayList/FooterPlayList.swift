//
//  FooterPlayList.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class FooterPlayList: BaseViewXib {
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func firstInit() {
        self.addNotification()
        self.setText()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeLanguage(notification:)), name: .ChangeLanguage, object: nil)
    }
    
    @objc func didChangeLanguage(notification: Notification) {
        self.setText()
    }
    
    func setText() {
        lblTitle.text = LocalizableKey.newPlaylist.localizeLanguage
    }
    
}
