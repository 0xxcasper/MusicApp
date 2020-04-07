//
//  SelectTimerPopUp.swift
//  MusicApp
//
//  Created by admin on 04/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

protocol SelectTimerPopUpDelegate: class {
    func didEndTimerCountDown()
}

class SelectTimerPopUp: BasePopUp, SelectTimerContentDelegate {
    
    
    weak var delegate: SelectTimerPopUpDelegate!
    
    var viewPopUp: SelectTimerContent = {
        let view = SelectTimerContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.backgroundColor = .black
        vContent.addSubview(viewPopUp)
        viewPopUp.delegate = self
        viewPopUp.fillSuperview()
    }
    
    func showPopUp() {
        super.showPopUp(width: AppConstant.SREEEN_WIDTH, height: 300, type: .showFromBottom)
    }
    
    func didEndTimer() {
        delegate.didEndTimerCountDown()
    }
    
    func onPressCancel() {
        hidePopUp()
    }
    
    func onPressStart() {
        hidePopUp()
    }
}
