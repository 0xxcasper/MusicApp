//
//  TrendingView.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit
import SDWebImage

protocol TrendingViewDelegate: class {
    func onPressViewSeeAll()
}
class TrendingView: BaseTableViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var btnSeeAll: UIButton!
    weak var delegate: TrendingViewDelegate!
    var items: [Item]! = [] {
        didSet {
            if items != nil {
                tbView.reloadData()
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitle()
        setUpViews()
        getData()
    }
    
    private func setUpViews() {
        tbView.registerXibFile(TrendingTbvCell.self)
        tbView.separatorStyle = .none
        tbView.dataSource = self
        tbView.delegate = self
        tbView.rowHeight = 64
        tbView.isScrollEnabled = false
    }
    
    private func setTitle() {
        lblTitle.text = LocalizableKey.trending.localizeLanguage + JsonHelper.getRegionName()
        btnSeeAll.setTitle(LocalizableKey.seeAll.localizeLanguage, for: .normal)
    }
    
    override func didChangeLanguage() {
        setTitle()
    }
    
    override func didChangeRegion() {
        setTitle()
        getData()
    }
    
    private func getData() {
        Provider.shared.callApiTrendingVideo(pageToken: "", success: { (BaseResponse) in
            self.items = BaseResponse.items
        }) { (error) in
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count >= 5 ? 5 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(TrendingTbvCell.self)
        let item = items[indexPath.row]
        if let snippet = item.snippet, let thumbnails = snippet.thumbnails {
            cell.img.loadImageFromInternet(link: thumbnails.defaults!.url!)
            cell.lblTitle.text = snippet.title
            cell.lblChanel.text = snippet.channelTitle
            cell.lblRow.text = "#\(indexPath.row + 1)"
        }
        return cell
    }
    
    
    @IBAction func onPressViewSeeAll(_ sender: UIButton) {
        delegate.onPressViewSeeAll()
    }
}
