//
//  PlayMusicBar.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class PlayMusicBar: BaseViewXib {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var btnControl: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
        
    override func setUpViews() {
        contentView.setGradient(startColor: UIColor(displayP3Red: 153/255, green: 54/255, blue: 129/255, alpha: 1),
                         secondColor: UIColor(displayP3Red: 53/255, green: 53/255, blue: 58/255, alpha: 1))
    }
    
    @IBAction func onPressPlayVideo(_ sender: UIButton) {
        
    }
}
