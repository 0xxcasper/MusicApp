//
//  PlayListCell.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit
import SwipeCellKit

class PlayListCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var row: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
