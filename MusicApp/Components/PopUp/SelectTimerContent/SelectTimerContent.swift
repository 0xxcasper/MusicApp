//
//  SelectTimerContent.swift
//  MusicApp
//
//  Created by admin on 06/04/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

protocol SelectTimerContentDelegate: class {
    func onPressCancel()
    func onPressStart()
    func didEndTimer()
}

class SelectTimerContent: BaseViewXib {
    @IBOutlet weak var lblCountDown: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var stView: UIStackView!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    private var timer: Timer?

    weak var delegate: SelectTimerContentDelegate!
    
    private var minitues: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    private var hours: [Int] = [0, 1, 2, 3, 4]
    
    private var currentH = 0 {
        didSet {
            guard let index = hours.firstIndex(of: currentH) else { return }
                   pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
    private var currentM = 5 {
        didSet {
            guard let index = minitues.firstIndex(of: currentM) else { return }
                   pickerView.selectRow(index, inComponent: 1, animated: true)
        }
    }
    
    private var isSetTimer = false {
        didSet {
            if isSetTimer {
                isPause = false
                counter = Float(currentH)*3600.0 + Float(currentM)*60.0
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                btnCancel.isHidden = true
                pickerView.isHidden = true
                btnStart.setTitle(LocalizableKey.done.localizeLanguage, for: .normal)
                lblTimer.text = LocalizableKey.countdown.localizeLanguage
                
                lblCountDown.isHidden = false
                stView.isHidden = false
            } else {
                counter = 0
                timer?.invalidate()
                
                btnCancel.isHidden = false
                pickerView.isHidden = false
                btnStart.setTitle(LocalizableKey.start.localizeLanguage, for: .normal)
                lblTimer.text = LocalizableKey.setTimer.localizeLanguage
                
                lblCountDown.isHidden = true
                stView.isHidden = true
            }
        }
    }
    
    private var isPause = false {
        didSet {
            if isPause {
                btnPause.setTitle(LocalizableKey.resume.localizeLanguage, for: .normal)
            } else {
                btnPause.setTitle(LocalizableKey.pause.localizeLanguage, for: .normal)
            }
        }
    }

    private var counter: Float = 0.0 {
        didSet {
            lblCountDown.text = counter.secondsToHoursMinutesSecondsTimer()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .ChangeLanguage, object: nil)
    }
    
    override func firstInit() {
        pickerView.dataSource = self
        pickerView.delegate = self
        lblTimer.text = LocalizableKey.setTimer.localizeLanguage
        btnStart.setTitle( LocalizableKey.start.localizeLanguage, for: .normal)
        btnCancel.setTitle(LocalizableKey.cancel.localizeLanguage, for: .normal)
        btnReset.setTitle(LocalizableKey.reset.localizeLanguage, for: .normal)
        btnPause.setTitle(LocalizableKey.pause.localizeLanguage, for: .normal)
        addNotification()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeLanguage(notification:)), name: .ChangeLanguage, object: nil)
    }
    
    @objc func didChangeLanguage(notification: Notification) {
        btnCancel.setTitle(LocalizableKey.cancel.localizeLanguage, for: .normal)
        btnPause.setTitle(isPause ? LocalizableKey.pause.localizeLanguage : LocalizableKey.resume.localizeLanguage , for: .normal)
        lblTimer.text = isSetTimer ? LocalizableKey.countdown.localizeLanguage  : LocalizableKey.setTimer.localizeLanguage
        btnStart.setTitle( isSetTimer ? LocalizableKey.done.localizeLanguage : LocalizableKey.start.localizeLanguage, for: .normal)
        btnReset.setTitle(LocalizableKey.reset.localizeLanguage, for: .normal)
        
    }

    @objc func updateCounter() {
        if !isPause {
            if counter > 0 {
                counter -= 1
            } else {
                isSetTimer = false
                delegate.didEndTimer()
            }
        }
        
    }
    
    @IBAction func onPressPause(_ sender: UIButton) {
       isPause = !isPause
    }
    
    @IBAction func onPressReset(_ sender: UIButton) {
        isSetTimer = false
    }
    
    @IBAction func onPressCancel(_ sender: UIButton) {
        delegate.onPressCancel()
    }
    
    @IBAction func onPressStart(_ sender: UIButton) {
        if !isSetTimer {
            isSetTimer = true
        }
        delegate.onPressStart()
    }
    
}


extension SelectTimerContent: UIPickerViewDataSource, UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? hours.count : minitues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(hours[row])" : "\(minitues[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { currentH = hours[row] } else { currentM = minitues[row] }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        if component == 0 {
            if currentH == hours[row] {
                attributedString = NSAttributedString(string: "\(hours[row]) h", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            } else {
                attributedString = NSAttributedString(string: "\(hours[row]) h", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
            }
        } else {
            if currentM == minitues[row] {
                attributedString = NSAttributedString(string: "\(minitues[row]) m", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            } else {
                attributedString = NSAttributedString(string: "\(minitues[row]) m", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
            }
        }
        return attributedString
    }
    
    
}
