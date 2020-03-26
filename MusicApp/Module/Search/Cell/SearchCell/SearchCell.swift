//
//  SearchCell.swift
//  MusicApp
//
//  Created by admin on 26/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class SearchCell: BaseTableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblChanel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
