//
//  SelectRateContent.swift
//  MusicApp
//
//  Created by admin on 04/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class SelectRateContent: BaseViewXib {
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func firstInit() {
        btnApply.isUserInteractionEnabled = true
        btnCancel.isUserInteractionEnabled = true
    }
}
