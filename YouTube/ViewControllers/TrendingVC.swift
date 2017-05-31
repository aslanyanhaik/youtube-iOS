//
//  TrendingVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/19/17.
//  Copyright © 2017 Haik Aslanyan. All rights reserved.
//

import UIKit

class TrendingVC: HomeVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
            cell.set(video: self.videos[indexPath.row - 1])
            return cell
        }
    }
}


