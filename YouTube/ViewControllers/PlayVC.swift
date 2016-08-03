//
//  PlayVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/25/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class PlayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var tableView: UITableView!
    internal var link: URL = globalVariables.videoLink
    var video: Video?
    
    //MARK: Delegate & dataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.video?.suggestedVideos.count {
            return count + 1
        } else {
            return 0
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! headerCell
            cell.title.text = self.video!.title
            cell.viewCount.text = "\(self.video!.viewCount) views"
            cell.likes.text = String(self.video!.likes)
            cell.disLikes.text = String(self.video!.disLikes)
            cell.channelTitle.text = self.video!.channelTitle
            cell.channelPic.image = self.video!.channelPic
            cell.channelPic.layer.cornerRadius = 25
            cell.channelPic.clipsToBounds = true
            cell.channelSubscribers.text = "\(self.video!.channelSubscribers) subscribers"
            returnCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! videoCell
            cell.name.text = self.video?.suggestedVideos[indexPath.row - 1].name
            cell.title.text = self.video?.suggestedVideos[indexPath.row - 1].title
            cell.tumbnail.image = self.video?.suggestedVideos[indexPath.row - 1].thumbnail
            returnCell = cell
        }
              return returnCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch indexPath.row {
        case 0:
            height = 180
        default:
            height = 90
        }
        return height
    }
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        Video.download(link: self.link) { (video) in
            self.video = video
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
    }

 }

class headerCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var disLikes: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var channelSubscribers: UILabel!
    
    //MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class videoCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var tumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    
    //MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
