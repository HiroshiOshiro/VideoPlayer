//
//  APIAccess.swift
//  VideoPlayer
//
//  Created by Hiroshi Oshiro on 2019/06/30.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import Foundation

class APIAccess {
    
    static private let baseURL = "https://quipper.github.io/native-technical-exam/playlist.json"
    
    static func getVideoInfo(completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: baseURL) else {
            return
        }

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
                    let videos = try decoder.decode([Video].self, from: d)
                    completion(videos)
                } catch {
                    print("error: ", error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
