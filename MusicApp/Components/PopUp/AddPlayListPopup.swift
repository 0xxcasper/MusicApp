//
//  SelectRatePopUp.swift
//  MusicApp
//
//  Created by admin on 04/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

protocol AddPlayListViewDelegate: class {
    func showCreatePlayList()
}

class AddPlayListPopup: BasePopUp {
    
    weak var delegate: AddPlayListViewDelegate?
    var song: ItemPlayList! = nil
    
    var viewPopUp: AddPlayListView = {
        let view = AddPlayListView()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        vContent.backgroundColor = .black
        viewPopUp.setupContent { (tapCreate) in
            self.delegate?.showCreatePlayList()
            self.hidePopUp()
        }
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()
        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
    }
    
    func showPopUp() {
        viewPopUp.song = self.song
        super.showPopUp(width: AppConstant.SREEEN_WIDTH, height: 450, type: .showFromBottom)
    }
    
    @objc func btnCancelTapped() {
        hidePopUp()
    }
}
