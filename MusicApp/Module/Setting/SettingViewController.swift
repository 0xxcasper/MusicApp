//
//  SettingViewController.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

enum SettingType {
    case language
    case country
}

class SettingViewController: BaseViewController {
    @IBOutlet weak var tbView: UITableView!
    
    var type: SettingType = .language
    
    private var data : [Region] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: type == .language ? LocalizableKey.changeLanguage.localizeLanguage : LocalizableKey.changeRegion.localizeLanguage)
        setUpViews()
        data = JsonHelper.readJSONFromFile(fileName: type == .language ? "Language" : "Region")
    }
    
    private func setUpViews() {
        tbView.registerXibFile(SettingCell.self)
        tbView.dataSource = self
        tbView.delegate = self
        tbView.separatorStyle = .none
    }
    
    override func didChangeLanguage() {
        setTitle(title: LocalizableKey.changeLanguage.localizeLanguage)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SettingCell.self, for: indexPath)
        cell.lblTitle.text = data[indexPath.row].name
        if type == .language {
            cell.imgCheck.isHidden = LanguageHelper.currentAppleLanguage() == data[indexPath.row].gl ? false : true
        } else {
            cell.imgCheck.isHidden = UserDefaultHelper.shared.regionCode == data[indexPath.row].gl ? false : true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .language {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType(rawValue: data[indexPath.row].gl)!)
            NotificationCenter.default.post(name: .ChangeLanguage, object: nil)
        } else {
            UserDefaultHelper.shared.regionCode = data[indexPath.row].gl
            NotificationCenter.default.post(name: .ChangeRegion, object: nil)
        }
        tbView.reloadData()
    }
}
