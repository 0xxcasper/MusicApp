//
//  HeaderView.swift
//  MusicApp
//
//  Created by admin on 27/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func onPressPlay()
}

class HeaderView: BaseViewXib {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblTracks: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    weak var delegate: HeaderViewDelegate!
    
    override func firstInit() {
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        
        btnPlay.layer.cornerRadius = 20
        btnPlay.clipsToBounds = true
    }
    
    @IBAction func onPressPlay(_ sender: UIButton) {
        delegate.onPressPlay()
    }
    
}
