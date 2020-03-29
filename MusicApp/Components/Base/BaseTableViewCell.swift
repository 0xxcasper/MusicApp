//
//  BaseTableViewCell.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell : UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .ChangeLanguage, object: nil)
        NotificationCenter.default.removeObserver(self, name: .ChangeRegion, object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addNotification()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeLanguage(notification:)), name: .ChangeLanguage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeRegion(notification:)), name: .ChangeRegion, object: nil)
    }
    
    @objc func didChangeLanguage(notification: Notification) {
        self.didChangeLanguage()
    }
    
    func didChangeLanguage() {
        
    }
    
    @objc func didChangeRegion(notification: Notification) {
        self.didChangeRegion()
    }
    
    func didChangeRegion() {
        
    }
    
}
