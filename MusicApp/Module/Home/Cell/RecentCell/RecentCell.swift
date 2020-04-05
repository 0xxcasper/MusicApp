//
//  RecentCell.swift
//  MusicApp
//
//  Created by Sang on 4/5/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class RecentCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.textColor = .white
    }

}
