//
//  VideoListViewController.swift
//  VideoPlayer
//
//  Created by hiroshi on 2019/06/23.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videoInfoList: [VideoInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// TableView
extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoItemCell", for: indexPath) as? VideoTableViewCell else {
            fatalError("Cell identifer is not correct!")
        }
        
        if let videoInfo = videoInfoList?[indexPath.row] {
            cell.setUpWithData(data: videoInfo)
        }
        
        return cell
    }
    
    
    
}
