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
    
    var videoInfoList: [VideoInfo]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        if let url = URL(string: "https://quipper.github.io/native-technical-exam/playlist.json") {
            getVideoInfo(url: url, completion: { (videos) in
                self.videoInfoList = videos
            })
        }
    }
    
    func getVideoInfo(url: URL, completion: @escaping ([VideoInfo]) -> Swift.Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check error
            if let e = error {
                print(e.localizedDescription)
                return
            }
            // check response
            if let r = response as? HTTPURLResponse,
                r.statusCode == 200,
                let d = data {
                let decoder = JSONDecoder()
                do {
                    let videos = try decoder.decode([VideoInfo].self, from: d)
                    completion(videos)
                } catch {
                    print("error: ", error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

struct Article: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var id: String
    }
}

// TableView
extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoInfoList?.count ?? 0
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
