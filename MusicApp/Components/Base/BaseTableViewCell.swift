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
    
}
