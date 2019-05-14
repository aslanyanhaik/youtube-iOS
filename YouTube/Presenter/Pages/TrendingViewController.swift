//
//  TrendingViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
 
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
 */
