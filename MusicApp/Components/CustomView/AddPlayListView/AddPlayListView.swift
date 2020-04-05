//
//  AddPlayListView.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

class AddPlayListView: BaseViewXib {
    weak var delegate: AddPlayListViewDelegate?
    private let footerView = FooterPlayList()
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var data: [PlaylistModel] = [] {
        didSet{
            tbView.reloadData()
        }
    }
    
    var song: ItemPlayList! = nil {
        didSet{
            tbView.reloadData()
        }
    }

    var tapCreate : ((Bool) -> Void)! = nil
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func firstInit() {
        self.backgroundColor = .black
        self.setUpView()
        self.getAllPlayList()
        self.addNotification()
        self.setText()
    }
    
    func getAllPlayList() {
        self.data = []
        self.data = Array(PlaylistModel.getAll())
    }
    
    private func setUpView() {
        tbView.registerXibFile(ContentPlayList.self)
        tbView.dataSource = self
        tbView.delegate = self
        tbView.separatorStyle = .none
    }
    
    func setupContent(tapCreate: ((Bool) -> Void)! = nil) {
        self.tapCreate = tapCreate
    }
    
    func checkIsExist(items: [ItemPlayList]) -> Bool{
        var isExist = false
        if (self.song == nil || items.count == 0) { return isExist}
        for (_, element) in items.enumerated() {
            if(element.id == song.id) {
                isExist = true
            }
        }
        
        return isExist
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
    }
}


extension AddPlayListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ContentPlayList.self, for: indexPath)
        let playlist = data[indexPath.row]
        cell.isExist = self.checkIsExist(items: Array(playlist.items))
        cell.lblName.text = playlist.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView.btnAdd.addTarget(self, action: #selector(btnCreateTapped), for: .touchUpInside)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ContentPlayList else { return }
        if(!cell.isExist) {
            let playlist = data[indexPath.row]
            playlist.addItem(item: self.song)
            self.getAllPlayList()
        }
    }
    
    @objc func btnCreateTapped() {
        if self.tapCreate != nil {
            self.tapCreate!(true)
        }
    }
    
}
