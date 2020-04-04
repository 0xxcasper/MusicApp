//
//  CreatePlayListView.swift
//  MusicApp
//
//  Created by Sang on 4/3/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

protocol CreatePlayListViewDelegate: class {
    func pressCancel()
    func pressCreate(_ text: String)
}

class CreatePlayListView: BaseViewXib {
    
    weak var delegate: CreatePlayListViewDelegate?

    @IBOutlet weak var txfInput: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    
    override func firstInit() {
        self.backgroundColor = .black
        self.txfInput.attributedPlaceholder = NSAttributedString(string: "Type playlist name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.txfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.btnApply.isUserInteractionEnabled = textField.text != nil && textField.text != ""
        self.btnApply.alpha = textField.text != nil && textField.text != "" ? 1 : 0.5
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        delegate?.pressCancel()
        self.txfInput.text = ""
    }
    
    @IBAction func pressApply(_ sender: Any) {
        delegate?.pressCreate(self.txfInput.text!)
        self.txfInput.text = ""
    }
}
