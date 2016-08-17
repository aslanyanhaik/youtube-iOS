//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class AccountCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    let menuTitles = ["History", "My Videos", "Notifications", "Watch Later"]
    var items = 5
    var user = User.init(name: "Loading", profilePic: UIImage(), backgroundImage: UIImage(), playlists: [Playlist]())
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods
    func fetchItem() {
        User.fetchProfile(link: globalVariables.profileLink) { (newUser) in
            self.user = newUser
            self.items = newUser.playlists.count + 5
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.collectionView?.reloadData()
            })
        }
    }
    
    func customization() {
        self.collectionView?.contentInset = UIEdgeInsetsMake(21, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(21, 0, 0, 0)
    }
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        fetchItem()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returncell = UICollectionViewCell()
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Header", for: indexPath) as! AccountHeaderCell
            cell.name.text = self.user.name
            cell.profilePic.image = self.user.profilePic
            cell.backgroundImage.image = self.user.backgroundImage
            returncell = cell
        case 1...4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! AccountMenuCell
            cell.separator.isHidden = true
            cell.menuTitles.text = self.menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage.init(named: self.menuTitles[indexPath.row - 1])
            if indexPath.row == 4 {
                cell.separator.isHidden = false
            }
            returncell = cell
        case 5...self.items:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Playlists", for: indexPath)as! AccountPlaylistCell
            cell.pic.image = self.user.playlists[indexPath.row - 5].pic
            cell.title.text = self.user.playlists[indexPath.row - 5].title
            cell.numberOfVideos.text = "\(self.user.playlists[indexPath.row - 5].numberOfVideos) videos"
            returncell = cell
        default: break
        }
    return returncell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.init(width: self.view.bounds.width, height: 70)
        switch indexPath.row {
        case 0:
            size.height = 120
        case 1...4:
            size.height = 50
        default: break
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
}

class AccountHeaderCell: UICollectionViewCell {
    
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: Inits
    override func awakeFromNib() {
        self.profilePic.layer.cornerRadius = 25
        self.profilePic.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class AccountMenuCell: UICollectionViewCell {
    
    //MARK: Properties
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitles: UILabel!
    @IBOutlet weak var separator: UIView!
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class AccountPlaylistCell: UICollectionViewCell {
    
    //MARK: Properties
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var numberOfVideos: UILabel!
    
    //MARK: Inits
    override func awakeFromNib() {
        self.pic.layer.cornerRadius = 5
        self.pic.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



