//
//  SelectRatePopUp.swift
//  MusicApp
//
//  Created by admin on 04/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

protocol SelectRatePopUpDelegate: class {
    func didSelectRate(rate: Float)
}

class SelectRatePopUp: BasePopUp {
    
    weak var delegate: SelectRatePopUpDelegate!
    var currentRate: Float = 1 {
        didSet {
            viewPopUp.currentRate = currentRate
        }
    }
    var viewPopUp: SelectRateContent = {
        let view = SelectRateContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.backgroundColor = .black
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()
        
        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
        viewPopUp.btnApply.addTarget(self, action: #selector(btnApplyTapped), for: .touchUpInside)
    }
    
    func showPopUp() {
        super.showPopUp(width: AppConstant.SREEEN_WIDTH, height: 300, type: .showFromBottom)
    }
    
    @objc func btnCancelTapped() {
        hidePopUp()
    }
    
    @objc func btnApplyTapped() {
        hidePopUp()
        delegate.didSelectRate(rate: viewPopUp.currentRate)
    }
}
