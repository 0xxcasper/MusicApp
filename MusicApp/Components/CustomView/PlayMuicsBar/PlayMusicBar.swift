//
//  PlayMusicBar.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
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
    
    @IBOutlet weak var containPlayView: UIView!
    private var timer: Timer?
    private var prevY: CGFloat = 0
    var reproductor = AVAudioPlayer()

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
                    self.img.loadImageFromInternet(link: video.snippet!.thumbnails!.defaults!.url ?? "", completion: nil)
                }
            } else {
                if items.count > 0, let itemVideos: [ItemSearch] = items as? [ItemSearch] {
                    let video = itemVideos[currentIndex]
                    self.currentId = video.id!.videoId ?? ""
                    self.lblTitle.text = video.snippet!.title
                    self.lblMusicName.text = video.snippet!.title
                    self.lblChanelName.text = video.snippet!.channelTitle
                    self.img.loadImageFromInternet(link: video.snippet!.thumbnails!.defaults!.url ?? "", completion: nil)
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
//            self.updateNowPlaying()
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
                if let timer = self.timer {timer.invalidate() }
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressVideo), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func firstInit() {
        videoPlayer.delegate = self
        contentViewPlay.alpha = 0
        contentViewHeader.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeGradientColor(notification:)), name: .ChangeGradientColor, object: nil)
        setupRemoteTransportControls()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .ChangeGradientColor, object: nil)
    }
    
    @objc func didChangeGradientColor(notification: Notification) {
        self.setGradientContentView()
    }
    
    func setGradientContentView() {
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
        if(contentView.layer.sublayers != nil && contentView.layer.sublayers!.count > 0 ) {
            for sublayer in contentView.layer.sublayers! {
                if sublayer.name == "gradient" {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
            contentView.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
    }
    
    func setGradientContentViewPlay() {
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
            if(self.contentViewPlay.layer.sublayers != nil && self.contentViewPlay.layer.sublayers!.count > 0 ) {
                for sublayer in self.contentViewPlay.layer.sublayers! {
                    if sublayer.name == "gradient" {
                        sublayer.removeFromSuperlayer()
                    }
                }
            }
            contentViewPlay.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
    }
    
    func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleInterruption),
                                       name: AVAudioSession.interruptionNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                        selector: #selector(handleRouteChange),
                                        name: AVAudioSession.routeChangeNotification,
                                        object: nil)
    }

    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }

        if type == .began {
            print("Interruption began")
            self.isPause = false
        }
        else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption Ended - playback should resume
                    print("Interruption Ended - playback should resume")
                    self.isPause = false
                } else {
                    
                }
            }
        }
    }
    

    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
                return
        }
        switch reason {
        case .newDeviceAvailable:
            let session = AVAudioSession.sharedInstance()
            for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.lineOut {
                print("headphones connected")
                DispatchQueue.main.sync {
                    self.isPause = false
                }
                break
            }
        case .oldDeviceUnavailable:
            if let previousRoute =
                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                for output in previousRoute.outputs where output.portType == AVAudioSession.Port.lineOut {
                    print("headphones disconnected")
                    DispatchQueue.main.sync {
                        self.isPause = false
                    }
                    break
                }
            }
        default: ()
        }
    }

        
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            print("Play command - is playing")
            if self.videoPlayer.playerState() != .playing {
                self.isPause = false
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            print("Pause command - is playing")
            if self.videoPlayer.playerState() == .playing {
                self.isPause = true
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            self.nextVideo()
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            self.prevVideo()
            return .success
        }
    }

    func updateNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        if let image = self.img.image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                return image
            }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.videoPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.videoPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.videoPlayer.playbackRate()
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientColor = UserDefaultHelper.shared.gradientColor {
            contentView.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
            contentViewPlay.setGradient(startColor: gradientColor[0], secondColor: gradientColor[1])
        }
        
        let volumeControl = MPVolumeView(frame: CGRect(x: (AppConstant.SREEEN_WIDTH - 250) / 2, y: containPlayView.frame.origin.y + containPlayView.bounds.height + 60 , width: 250, height: 120))
        self.addSubview(volumeControl);
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
        }) { (_) in
            self.setGradientContentViewPlay()
        }
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
    
    @IBAction func onChangeVolume(_ sender: UISlider) {
    }
    func setSystemVolume(volume: Float) {
        let volumeView = MPVolumeView()

        for view in volumeView.subviews {
            if (NSStringFromClass(view.classForCoder) == "MPVolumeSlider") {
                let slider = view as! UISlider
                slider.setValue(volume, animated: false)
            }
        }
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

extension MPVolumeView {
    var volumeSlider:UISlider {
        self.showsRouteButton = false
        self.showsVolumeSlider = false
        self.isHidden = true
        var slider = UISlider()
        for subview in self.subviews {
            if subview is UISlider {
                slider = subview as! UISlider
                slider.isContinuous = false
                (subview as! UISlider).value = AVAudioSession.sharedInstance().outputVolume
                return slider
            }
        }
        return slider
    }
}
