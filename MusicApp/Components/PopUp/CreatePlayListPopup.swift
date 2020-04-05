//
//  createPlayListPopup.swift
//  MusicApp
//
//  Created by Sang on 4/5/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation


class CreatePlayListPopup: BasePopUp {
        
    var viewPopUp: CreatePlayListView = {
        let view = CreatePlayListView()
        return view
    }()
    
    var song: ItemPlayList! = nil
    
    override func setupView() {
        super.setupView()
        vContent.backgroundColor = .black
        vContent.addSubview(viewPopUp)
        viewPopUp.delegate = self
        self.addObserverKeyboard()
        viewPopUp.fillSuperview()
    }
    
    func showPopUp() {
        super.showPopUp(width: AppConstant.SREEEN_WIDTH, height: 120, type: .showFromBottom)
        viewPopUp.txfInput.becomeFirstResponder()
    }
    
    @objc func btnCancelTapped() {
        hidePopUp()
    }
}

extension CreatePlayListPopup: CreatePlayListViewDelegate {
    func pressCancel() {
        hidePopUp()
    }
    
    func pressCreate(_ text: String, type: CreatePlayListType) {
        switch type {
        case .create:
            if !Array(PlaylistModel.getAll()).contains(where: {$0.name == text}) {
                let playList = PlaylistModel.add(name: text)
                playList.addItem(item: self.song)
            }
            break
        default:
            print("pressCreate")
        }
        self.endEditing(true)
        hidePopUp()
    }
}
