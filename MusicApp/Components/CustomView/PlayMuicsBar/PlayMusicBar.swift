//
//  PlayMusicBar.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class PlayMusicBar: BaseViewXib {
    @IBOutlet weak var contentViewHeader: UIView!
    @IBOutlet weak var contentViewPlay: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var btnControl: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var videoPlayer: YTPlayerView!
    @IBOutlet weak var lblMusicName: UILabel!
    @IBOutlet weak var lblChanelName: UILabel!
    @IBOutlet weak var btnControlVideo: UIButton!
    @IBOutlet weak var largeIndicator: UIActivityIndicatorView!
    
    private var timer: Timer?
    private var prevY: CGFloat = 0
    
    var type: PlaylistType = .search
    
    var items: [Any] = []
    
    var currentIndex = 0 {
        didSet {
            if type == .trending {
                if items.count > 0, let itemVideos: [Item] = items as? [Item] {
                    let video = itemVideos[currentIndex]
                    self.currentId = video.id ?? ""
                    self.lblTitle.text = video.snippet!.title
                    self.lblMusicName.text = video.snippet!.title
                    self.lblChanelName.text = video.snippet!.channelTitle
                    self.img.loadImageFromInternet(link: video.snippet!.thumbnails!.defaults!.url ?? "")
                }
            } else {
                if items.count > 0, let itemVideos: [ItemSearch] = items as? [ItemSearch] {
                    let video = itemVideos[currentIndex]
                    self.currentId = video.id!.videoId ?? ""
                    self.lblTitle.text = video.snippet!.title
                    self.lblMusicName.text = video.snippet!.title
                    self.lblChanelName.text = video.snippet!.channelTitle
                    self.img.loadImageFromInternet(link: video.snippet!.thumbnails!.defaults!.url ?? "")
                }
            }
        }
    }
    
    var currentId = "" {
        didSet {
            self.videoPlayer.isHidden = true
            self.indicator.isHidden = false
            self.largeIndicator.isHidden = false
            self.btnControl.isHidden = true
            self.btnControlVideo.isHidden = true
            let playvarsDic = ["controls": 0, "modestbranding": 0, "rel": 0,"showinfo": 0, "fs": 0, "playsinline": 1] as [String : Any]
            self.videoPlayer.load(withVideoId: currentId, playerVars: playvarsDic)
        }
    }
    
    var isPause = true {
        didSet {
            if isPause {
                self.btnControl.setImage(#imageLiteral(resourceName: "play_small"), for: .normal)
                self.btnNext.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
                self.btnControlVideo.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                self.videoPlayer.pauseVideo()
            } else {
                self.btnControl.setImage(#imageLiteral(resourceName: "pause_small"), for: .normal)
                self.btnNext.setImage(#imageLiteral(resourceName: "next_small"), for: .normal)
                self.btnControlVideo.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                self.videoPlayer.playVideo()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressVideo), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func firstInit() {
        videoPlayer.delegate = self
        contentViewPlay.alpha = 0
        contentViewHeader.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeGradientColor(notification:)), name: .ChangeGradientColor, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .ChangeGradientColor, object: nil)
    }
    
    @objc func didChangeGradientColor(notification: Notification) {
        self.setGradientContentView()
        self.setGradientContentViewPlay()
    }
    
    func setGradientContentView() {
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
            guard let sublayers = contentView.layer.sublayers else {
                contentView.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
                return
            }
            sublayers[0].removeFromSuperlayer()
            contentView.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
    }
    func setGradientContentViewPlay() {
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
            guard let sublayers = contentView.layer.sublayers else {
                contentViewPlay.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
                return
            }
            sublayers[0].removeFromSuperlayer()
            contentViewPlay.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
            contentView.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
            contentViewPlay.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
    }
    
    @objc func progressVideo() {
        let currentTime = videoPlayer.currentTime()
        let duration = videoPlayer.duration()
        if currentTime > Float(duration) {
            timer?.invalidate()
            progressView.setProgress(1.0, animated: true)
        } else {
            progressView.setProgress(currentTime/(Float(duration) == 0.0 ? 1 : Float(duration)), animated: false)
        }
    }
    
    private func nextVideo() {
        if currentIndex + 1 < items.count {
            currentIndex = currentIndex + 1
        } else {
            currentIndex = 0
        }
    }
    
    private func prevVideo() {
        if currentIndex - 1 > 0 {
            currentIndex = currentIndex - 1
        } else {
            currentIndex = self.items.count - 1
        }
    }
    
    @IBAction func onPressClock(_ sender: Any) {
        
    }
    
    
    @IBAction func onPressBack(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentViewPlay.alpha = 0
            self.contentViewHeader.alpha = 0
            self.contentView.alpha = 1
            self.frame = CGRect(x: 0, y: self.prevY, width: AppConstant.SREEEN_WIDTH, height: 48)
        })
    }
    
    @IBAction func onPressPlayBar(_ sender: UIButton) {
        self.prevY = self.frame.origin.y
        UIView.animate(withDuration: 0.2, animations: {
            self.contentViewPlay.alpha = 1
            self.contentViewHeader.alpha = 1
            self.contentView.alpha = 0
            self.frame = CGRect(x: 0, y: 0, width: AppConstant.SREEEN_WIDTH, height: AppConstant.SCREEN_HEIGHT)
        })
    }
    
    @IBAction func onPressPlayVideo(_ sender: UIButton) {
        isPause = !isPause
    }
    
    @IBAction func onPressNextVideo(_ sender: UIButton) {
        if sender.tag == 1 {
            nextVideo()
        } else {
            if sender.imageView?.image == #imageLiteral(resourceName: "cancel") {
                animateHideLeftToRight()
            } else {
                nextVideo()
            }
        }
    }
    
    @IBAction func onPressPrevVideo(_ sender: UIButton) {
        prevVideo()
    }
}

extension PlayMusicBar: YTPlayerViewDelegate
{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.isPause = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
           self.indicator.isHidden = true
           self.largeIndicator.isHidden = true
           self.btnControl.isHidden = false
           self.btnControlVideo.isHidden = false
           self.videoPlayer.isHidden = false
        }
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        nextVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .unstarted || state == .ended {
            nextVideo()
        }
    }
}
