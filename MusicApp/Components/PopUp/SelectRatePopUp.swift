//
//  SelectRatePopUp.swift
//  MusicApp
//
//  Created by admin on 04/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation


class SelectRatePopUp: BasePopUp {
    
    let viewPopUp: SelectRateContent = {
        let view = SelectRateContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.backgroundColor = .black
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()
    }
    
    func showPopUp() {
        super.showPopUp(width: AppConstant.SREEEN_WIDTH, height: 300, type: .showFromBottom)
    }
}
