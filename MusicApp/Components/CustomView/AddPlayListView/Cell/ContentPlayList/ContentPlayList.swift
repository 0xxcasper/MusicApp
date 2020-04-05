//
//  ContentPlayList.swift
//  MusicApp
//
//  Created by Sang on 4/5/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class ContentPlayList: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgChecked: UIImageView!
    
    var isExist: Bool = false {
        didSet {
            lblName.textColor = self.isExist ? UIColor.lightGray : UIColor.white
            imgChecked.isHidden = !self.isExist
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
