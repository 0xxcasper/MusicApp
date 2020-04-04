//
//  AddPlayListView.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

protocol AddPlayListViewDelegate: class {
    func hideAddPlayListView()
}

class AddPlayListView: BaseViewXib {
    weak var delegate: AddPlayListViewDelegate?
    var song: PlaylistModel! = nil
    
    @IBOutlet weak var tbView: UITableView!
    
    override func firstInit() {
        self.backgroundColor = .black
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        self.delegate?.hideAddPlayListView()
    }
}


extension AddPlayListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
