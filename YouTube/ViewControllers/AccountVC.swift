//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let menuTitles = ["History", "My Videos", "Notifications", "Watch Later"]
    var items = 5
    var user = User.init(name: "Loading", profilePic: UIImage(), backgroundImage: UIImage(), playlists: [Playlist]())
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods

    func customization() {
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        User.fetchData { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            weakSelf.user = response
            weakSelf.items += response.playlists.count
            weakSelf.tableView.reloadData()
        }
    }
    
    // MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! AccountHeaderCell
            cell.name.text = self.user.name
            cell.profilePic.image = self.user.profilePic
            cell.backgroundImage.image = self.user.backgroundImage
            return cell
        case 1...4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! AccountMenuCell
            cell.menuTitles.text = self.menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage.init(named: self.menuTitles[indexPath.row - 1])
           return cell
        case 5...self.items:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Playlists", for: indexPath) as! AccountPlaylistCell
            cell.pic.image = self.user.playlists[indexPath.row - 5].pic
            cell.title.text = self.user.playlists[indexPath.row - 5].title
            cell.numberOfVideos.text = "\(self.user.playlists[indexPath.row - 5].numberOfVideos) videos"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! AccountMenuCell
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
}

class AccountHeaderCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePic.layer.cornerRadius = 25
        self.profilePic.clipsToBounds = true
    }
}

class AccountMenuCell: UITableViewCell {
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitles: UILabel!
    
}

class AccountPlaylistCell: UITableViewCell {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var numberOfVideos: UILabel!
    
    override func awakeFromNib() {
        self.pic.layer.cornerRadius = 5
        self.pic.clipsToBounds = true
    }
}



