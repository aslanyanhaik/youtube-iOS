//
//  FeedVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/18/17.
//  Copyright © 2017 Haik Aslanyan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods
    func customization() {
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 30, 0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
    }
    
    func fetchData() {
        Video.fetchVideos { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            weakSelf.videos = response
            weakSelf.videos.shuffle()
            weakSelf.tableView.reloadData()
        }
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.set(video: self.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
        self.fetchData()
    }
}

//TableView Custom Classes
class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    
    func customization()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.durationLabel.layer.borderWidth = 0.5
        self.durationLabel.layer.borderColor = UIColor.white.cgColor
        self.durationLabel.sizeToFit()
    }
    
    func set(video: Video)  {
        self.videoThumbnail.image = video.thumbnail
        self.durationLabel.text = " \(video.duration.secondsToFormattedString()) "
        self.durationLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.durationLabel.layer.borderWidth = 1.0
        self.channelPic.image = video.channel.image
        self.videoTitle.text = video.title
        self.videoDescription.text = "\(video.channel.name)  • \(video.views)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoThumbnail.image = UIImage.init(named: "emptyTumbnail")
        self.durationLabel.text = nil
        self.channelPic.image = nil
        self.videoTitle.text = nil
        self.videoDescription.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customization()
    }
}
