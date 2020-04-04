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
    
    var currentRate: Float = 1.0 {
        didSet {
            guard let index = data.firstIndex(of: currentRate) else { return }
                   pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
    private var data: [Float] = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
    
    override func firstInit() {
        btnApply.isUserInteractionEnabled = true
        btnCancel.isUserInteractionEnabled = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    override func layoutSubviews() {
       
    }
}

extension SelectRateContent: UIPickerViewDataSource, UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row])x"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRate = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!

        if currentRate == data[row] {
            attributedString = NSAttributedString(string: "\(data[row])x", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            attributedString = NSAttributedString(string: "\(data[row])x", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
        }

        return attributedString
    }
    
    
}
