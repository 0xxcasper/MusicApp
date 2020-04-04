//
//  PlayListCell.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class PlayListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func didTransition(to state: UITableViewCell.StateMask) {
        super.willTransition(to: state)
        if state == .showingDeleteConfirmation {
            let deleteButton: UIView? = subviews.first(where: { (aView) -> Bool in
                return String(describing: aView).contains("Delete")
            })
            if deleteButton != nil {
                deleteButton?.frame.size.height = 50.0
            }
        }
    }
}
