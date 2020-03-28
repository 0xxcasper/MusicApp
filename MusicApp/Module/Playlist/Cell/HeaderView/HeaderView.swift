//
//  HeaderView.swift
//  MusicApp
//
//  Created by admin on 27/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class HeaderView: BaseViewXib {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
    override func setUpViews() {
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        
        btnPlay.layer.cornerRadius = 20
        btnPlay.clipsToBounds = true
    }
    
    @IBAction func onPressPlay(_ sender: UIButton) {
        
    }
    
}
