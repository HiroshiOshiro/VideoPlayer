//
//  CMTime+Text.swift
//  VideoPlayer
//
//  Created by Hiroshi Oshiro on 2019/06/30.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import CoreMedia

extension CMTime {
    var durationText: String {
        if CMTimeGetSeconds(self).isNaN {
            return ""
        } else {
            let totalSeconds = CMTimeGetSeconds(self)
            let hours: Int = Int(totalSeconds / 3600)
            let minutes: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
            let seconds: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
            
            if hours > 0 {
                return String(format: "%i:%02i:%02i", hours, minutes, seconds)
            } else {
                return String(format: "%02i:%02i", minutes, seconds)
            }
        }
    }
}
