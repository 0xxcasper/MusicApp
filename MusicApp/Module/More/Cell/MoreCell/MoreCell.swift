//
//  MoreCell.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class MoreCell: BaseTableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
