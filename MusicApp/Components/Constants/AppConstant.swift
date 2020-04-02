//
//  AppConstant.swift
//  BrowserApp
//
//  Created by admin on 25/11/2019.
//  Copyright © 2019 nxsang063@gmail.com. All rights reserved.
//

import Foundation
import UIKit

let api_key =  "AIzaSyDT6DczdeKqckkp8qxDXNxo02Uw1jL4Je4"//"AIzaSyBw6nKP38wy-GtLEMPxKRfSGLrCWcf88gk"

struct AppConstant {
    
    static let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    static let SREEEN_WIDTH = SCREEN_SIZE.width
    static let SCREEN_HEIGHT = SCREEN_SIZE.height
    static let STATUS_BAR_BOTTOM = SCREEN_HEIGHT >= 812 || SREEEN_WIDTH >= 812 ? CGFloat(44) : CGFloat(28)
    static let STATUS_BAR_TOP = SCREEN_HEIGHT >= 812 ? CGFloat(44) : CGFloat(20)
    static let TOOL_BAR_HEIGHT = CGFloat(44)
    static let NAVI_BAR_HEIGHT = CGFloat(44)
    
    static let HEIGTH_TABBAR: CGFloat = 30 + STATUS_BAR_BOTTOM
    
    static let colors: [[UIColor]] =
    [
        [UIColor(displayP3Red: 100/255, green: 50/255, blue: 194/255, alpha: 1), UIColor(displayP3Red: 62/255, green: 17/255, blue: 145/255, alpha: 1)],
        [UIColor(displayP3Red: 238/255, green: 182/255, blue: 140/255, alpha: 1), UIColor(displayP3Red: 226/255, green: 125/255, blue: 78/255, alpha: 1)],
        [UIColor(displayP3Red: 167/255, green: 172/255, blue: 217/255, alpha: 1), UIColor(displayP3Red: 158/255, green: 143/255, blue: 178/255, alpha: 1)],
        [UIColor(displayP3Red: 255/255, green: 175/255, blue: 189/255, alpha: 1), UIColor(displayP3Red: 255/255, green: 195/255, blue: 160/255, alpha: 1)],
        [UIColor(displayP3Red: 33/255, green: 147/255, blue: 176/255, alpha: 1), UIColor(displayP3Red: 109/255, green: 213/255, blue: 237/255, alpha: 1)],
        [UIColor(displayP3Red: 204/255, green: 43/255, blue: 94/255, alpha: 1), UIColor(displayP3Red: 117/255, green: 58/255, blue: 136/255, alpha: 1)],
        [UIColor(displayP3Red: 238/255, green: 156/255, blue: 167/255, alpha: 1), UIColor(displayP3Red: 255/255, green: 221/255, blue: 225/255, alpha: 1)],
        [UIColor(displayP3Red: 66/255, green: 39/255, blue: 90/255, alpha: 1), UIColor(displayP3Red: 115/255, green: 75/255, blue: 109/255, alpha: 1)],
        [UIColor(displayP3Red: 189/255, green: 195/255, blue: 199/255, alpha: 1), UIColor(displayP3Red: 44/255, green: 62/255, blue: 80/255, alpha: 1)],
        [UIColor(displayP3Red: 222/255, green: 98/255, blue: 98/255, alpha: 1), UIColor(displayP3Red: 255/255, green: 184/255, blue: 140/255, alpha: 1)],
        [UIColor(displayP3Red: 9/255, green: 32/255, blue: 63/255, alpha: 1), UIColor(displayP3Red: 83/255, green: 120/255, blue: 149/255, alpha: 1)],
        [UIColor(displayP3Red: 235/255, green: 51/255, blue: 73/255, alpha: 1), UIColor(displayP3Red: 244/255, green: 92/255, blue: 67/255, alpha: 1)],
        [UIColor(displayP3Red: 221/255, green: 94/255, blue: 137/255, alpha: 1), UIColor(displayP3Red: 247/255, green: 187/255, blue: 151/255, alpha: 1)],
        [UIColor(displayP3Red: 86/255, green: 171/255, blue: 47/255, alpha: 1), UIColor(displayP3Red: 168/255, green: 224/255, blue: 99/255, alpha: 1)],
        [UIColor(displayP3Red: 170/255, green: 7/255, blue: 107/255, alpha: 1), UIColor(displayP3Red: 97/255, green: 4/255, blue: 95/255, alpha: 1)],
        [UIColor(displayP3Red: 255/255, green: 153/255, blue: 102/255, alpha: 1), UIColor(displayP3Red: 255/255, green: 94/255, blue: 98/255, alpha: 1)],
        [UIColor(displayP3Red: 255/255, green: 237/255, blue: 188/255, alpha: 1), UIColor(displayP3Red: 237/255, green: 66/255, blue: 100/255, alpha: 1)],
        [UIColor(displayP3Red: 255/255, green: 126/255, blue: 95/255, alpha: 1), UIColor(displayP3Red: 254/255, green: 180/255, blue: 123/255, alpha: 1)],
    ]
}

