//
//  SearchCell.swift
//  MusicApp
//
//  Created by admin on 26/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

protocol SearchCellDelegate: class {
    func addPlayList(item: ItemPlayList)
}

class SearchCell: BaseTableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblChanel: UILabel!
    
    weak var delegate: SearchCellDelegate?
    var item: ItemPlayList! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func pressAddPlayList(_ sender: Any) {
        if(self.item != nil) {
            self.delegate?.addPlayList(item: self.item)
        }
    }
}
