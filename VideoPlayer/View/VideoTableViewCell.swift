//
//  VideoTableViewCell.swift
//  VideoPlayer
//
//  Created by hiroshi on 2019/06/23.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageBaseView: UIView!
    
    func setUpWithData(data: VideoInfo) {
        titleLabel.text = data.title
        presenterNameLabel.text = data.presenterName
        descriptionLabel.text = data.description
        loadingIndicator.startAnimating()
        
        if let url = URL(string: data.thumbnailUrl) {
            thumbnailImageView
                .loadImageAsynchronously(url: url,
                                         completion: {(result) in
                                            if result {
                                                self.loadingIndicator.stopAnimating()
                                            }
                })
        }
    }
}


