//
//  UIView+Extension.swift
//  BrowserApp
//
//  Created by admin on 26/11/2019.
//  Copyright © 2019 nxsang063@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

// MARK: Auto Layout
extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {

        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }

    // TODOs: with Supper view

    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if #available(iOS 11.0, *) {
                leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            }
        }
    }

    func fillSuperviewNotSafe() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }

    func fillHorizontalSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if #available(iOS 11, *) {
                leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: constant).isActive = true
                rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -constant).isActive = true
            } else {
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            }
        }
    }

    func fillVerticalSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if #available(iOS 11, *) {
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
            } else {
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }

        }
    }

    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }

    func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})

        return anchors
    }

    func centerXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            if let anchor = superview?.safeAreaLayoutGuide.centerXAnchor {
                centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        } else {
            if let anchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        }
    }

    func centerYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            if let anchor = superview?.safeAreaLayoutGuide.centerYAnchor {
                centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        } else {
            if let anchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        }
    }

    func centerSuperview() {
        centerXToSuperview()
        centerYToSuperview()
    }

    // TODOs: With other view
    func fillToView(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
            rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }

    }

    func centerXToView(view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11, *) {
            centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: constant).isActive = true
        } else {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        }
    }

    func centerYToView(view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: constant).isActive = true
        } else {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        }

    }

    func centerToView(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXToView(view: view)
        centerYToView(view: view)
    }

    func fillHorizontalToView(view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant).isActive = true
            rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -constant).isActive = true
        } else {
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).isActive = true
        }

    }

    func fillVerticalToView(view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
        } else {
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        }

    }

    func setShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        //        let newBound = CGRect(x: self.bounds.minX + 5, y: self.bounds.minY + 10, width: self.bounds.width - 5, height: self.bounds.height)

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
    }

    func setViewBorder(width: CGFloat = 1, color: UIColor = .black) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}

extension UIView {
    func setGradient(startColor: UIColor = .white, secondColor:UIColor = .black) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor,
                           secondColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    
    func flash(completion: (() -> Void)? = nil) {
        CATransaction.begin()
        
        let flash = CABasicAnimation(keyPath: "opacity")
        
        flash.duration = 0.2
       
        flash.fromValue = 1
         
        flash.toValue = 0.1
        
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        CATransaction.setCompletionBlock(completion)
        layer.add(flash, forKey: nil)
        
         CATransaction.commit()
    }
    
    func animateLeftToRight() {
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.x = 0
        }
    }
    
    func animateHideLeftToRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = -AppConstant.SREEEN_WIDTH
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
}


extension UIImageView{
    func loadImageFromInternet(link: String, completion: ((_ success:Bool) -> Void)?) {
        guard let url = URL(string: link) else {
            return
        }
        self.sd_imageTransition = SDWebImageTransition.flipFromLeft
        self.sd_setImage(with: url) { (UIImage, Error, SDImageCacheType, URL) in
            if completion != nil {
                completion!(true)
            }
        }
    }
}

extension UISearchBar {

        func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
        func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
        func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
        func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

        func setTextField(color: UIColor) {
            guard let textField = getTextField() else { return }
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 8
            case .prominent, .default: textField.backgroundColor = color
            @unknown default: break
            }
        }

        func setSearchImage(color: UIColor) {
            guard let imageView = getTextField()?.leftView as? UIImageView else { return }
            imageView.tintColor = color
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        }
    
        func setTitleCancel(title: String) {
        
            var cancelButton: UIButton
            for subView in self.subviews {
                if subView.isKind(of: UIButton.self) {
                    cancelButton = subView as! UIButton
                    cancelButton.setTitle(title, for: .normal)
                }
            }
            self.autocorrectionType = .no
        }
    }

    private extension UITextField {

    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }


    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = ""
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }

    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }

    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        placeholderLabel.removeFromSuperview() // To remove existing label. Otherwise it will overwrite it if called multiple times.
        setValue(label, forKey: "placeholderLabel")
    }

    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }

}
