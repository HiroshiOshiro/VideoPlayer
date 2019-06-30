//
//  PlayerViewController.swift
//  VideoPlayer
//
//  Created by Hiroshi Oshiro on 2019/06/28.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
    var playingTimeLabel: UILabel!
    
    var videoInfo: Video? = nil
    
    var timeObserverToken: Any?
    
    let timeLabelHight: CGFloat = 20.0
    
    var currentOrientation: UIInterfaceOrientation?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let url = URL(string: videoInfo?.videoUrl ?? "") else {
            return
        }

        let videoPlayer = AVPlayer(url: url)
        self.player = videoPlayer
        self.player?.play()
        
        // set periodical function
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        timeObserverToken = self.player?.addPeriodicTimeObserver(forInterval: time, queue: nil, using: {[weak self] time in
            self?.setCurrentTime()
        })

        NotificationCenter.default.addObserver(self, selector: #selector(onOrientationDidChange(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    
    @objc func onOrientationDidChange(notification: NSNotification) {
        print("onOrientationDidChange")
        if currentOrientation !=  UIApplication.shared.statusBarOrientation {
            setTimeLabel()
            currentOrientation = UIApplication.shared.statusBarOrientation
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTimeLabel()
    }
    
    /// set label to show "current time" / "total time" in the video
    private func setTimeLabel() {
        let newLabel = UILabel()
        newLabel.frame.size = CGSize(width: 200.0, height: timeLabelHight);
        newLabel.textAlignment = .center
        
        if #available(iOS 11.0, *) {
            newLabel.center = CGPoint(x: self.view.frame.width / 2,
                                               y: (self.view.safeAreaInsets.top + timeLabelHight / 2))
        } else {
            newLabel.center = CGPoint(x: self.view.frame.width / 2, y: 0 + timeLabelHight / 2)
        }
        print(newLabel.frame)
        
        newLabel.textColor = .lightGray
        self.view.addSubview(newLabel)
        if playingTimeLabel != nil {
            playingTimeLabel.removeFromSuperview()
        }
        playingTimeLabel = newLabel
    }
    
    private func setCurrentTime() {
        // total time
        let duration = self.player?.currentItem!.duration.durationText
        
        // current time
        let time = self.player?.currentTime().durationText
        
        playingTimeLabel?.text = (time ?? "") + "/" + (duration ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // remove time observer
        if let timeObserverToken = timeObserverToken {
            self.player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}
