//
//  BackGroundViewController.swift
//  MusicApp
//
//  Created by Sang on 4/2/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import UIKit

class BackGroundViewController: BaseViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var color: [UIColor] = [] {
        didSet {
            guard let sublayers = gradientView.layer.sublayers else {
                self.gradientView.setGradient(startColor: color[0], secondColor: color[1])
                return
            }
            sublayers[0].removeFromSuperlayer()
            self.gradientView.setGradient(startColor: color[0], secondColor: color[1])
        }
    }
    private let type: SettingType = .colors

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.color = UserDefaultHelper.shared.gradientColor
    }
    
    private func setUpViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nibWithCellClass: GradientCell.self)
    }

    @IBAction func pressCancel(_ sender: Any) {
        self.dismiss()
    }
    @IBAction func pressApply(_ sender: Any) {
        UserDefaultHelper.shared.gradientColor = color
        NotificationCenter.default.post(name: .ChangeGradientColor, object: color)
    }
}

extension BackGroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConstant.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GradientCell.self, for: indexPath)
        let colors = AppConstant.colors[indexPath.row]
        cell.setGradient(startColor: colors[0], secondColor: colors[1])
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.color = AppConstant.colors[indexPath.row]
    }
}

extension BackGroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 3
        return CGSize(width: width, height: width * 0.6)
    }
}
