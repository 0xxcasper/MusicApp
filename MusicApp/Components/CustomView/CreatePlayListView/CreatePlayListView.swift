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
    func pressCreate(_ text: String, type: CreatePlayListType)
}

enum CreatePlayListType {
    case create
    case edit
}

class CreatePlayListView: BaseViewXib {
    
    weak var delegate: CreatePlayListViewDelegate?
    var cellType: CreatePlayListType = .create
    

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnApply: UIButton!

    @IBOutlet weak var txfInput: UITextField!
    
    deinit {
         NotificationCenter.default.removeObserver(self, name: .ChangeLanguage, object: nil)
     }
    override func firstInit() {
        self.backgroundColor = .black
        self.txfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.addNotification()
        self.setText()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.btnApply.isUserInteractionEnabled = textField.text != nil && textField.text != ""
        self.btnApply.alpha = textField.text != nil && textField.text != "" ? 1 : 0.5
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeLanguage(notification:)), name: .ChangeLanguage, object: nil)
    }
    
    @objc func didChangeLanguage(notification: Notification) {
        self.setText()
    }
    
    func setText() {
        lblTitle.text = LocalizableKey.newPlaylist.localizeLanguage
        btnCancel.setTitle(LocalizableKey.cancel.localizeLanguage, for: .normal)
        btnApply.setTitle(LocalizableKey.create.localizeLanguage, for: .normal)
        txfInput.attributedPlaceholder = NSAttributedString(string: LocalizableKey.typePlaylistName.localizeLanguage, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        delegate?.pressCancel()
        self.txfInput.text = ""
    }
    
    @IBAction func pressApply(_ sender: Any) {
        delegate?.pressCreate(self.txfInput.text!, type: self.cellType)
        self.txfInput.text = ""
    }
}
