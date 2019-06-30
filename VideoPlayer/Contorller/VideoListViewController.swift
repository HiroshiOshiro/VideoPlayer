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
    
    var videos: [Video]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTable()
        
        APIAccess.getVideoInfo(completion: { (videos) in
            self.videos = videos
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // deselect selected cell
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPlayerView") {
            let playerView = segue.destination as! PlayerViewController
            playerView.videoInfo = (sender as? Video)
        }
    }
    
    private func setTable() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// TableView
extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoItemCell", for: indexPath) as? VideoTableViewCell else {
            fatalError("Cell identifer is not correct!")
        }
        
        if let videoInfo = videos?[indexPath.row] {
            cell.setUpWithData(data: videoInfo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vi = videos?[indexPath.row] {
            performSegue(withIdentifier: "toPlayerView", sender: vi)
        }
    }
}
