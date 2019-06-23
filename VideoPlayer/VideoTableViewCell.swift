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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpWithData(data: VideoInfo) {
        titleLabel.text = data.title
        presenterNameLabel.text = data.presenterName
        descriptionLabel.text = data.description
        
    }
}
