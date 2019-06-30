//
//  VideoInfo.swift
//  VideoPlayer
//
//  Created by hiroshi on 2019/06/23.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import Foundation

struct Video: Codable {
    let title: String
    let presenterName: String
    let description: String
    let thumbnailUrl: String
    let videoUrl: String
    let videoDuration: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case presenterName = "presenter_name"
        case description
        case thumbnailUrl = "thumbnail_url"
        case videoUrl = "video_url"
        case videoDuration = "video_duration"
    }
}


