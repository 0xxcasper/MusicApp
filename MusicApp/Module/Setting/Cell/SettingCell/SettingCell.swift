//
//  SettingCell.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class SettingCell: BaseTableViewCell {
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
