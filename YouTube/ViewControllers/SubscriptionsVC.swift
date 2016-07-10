//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class SubscriptionsCollectionViewController: FeedCollectionViewController {
    
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsList.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returncell = UICollectionViewCell()
        if indexPath.row == 0 {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "Top", for: indexPath) as! SubscriptionsProfilePicCell
            returncell = cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
            cell.resetCell()
            if let video = videoItems[indexPath.row - 1] {
                cell.setupCell(videoItem: video)
            } else{
                Video.object(at: (indexPath.row - 1), fromList: itemsList, completiotion: { (video, index) in
                    self.videoItems[index] = video
                    DispatchQueue.main.async(execute: {
                        self.collectionView?.reloadData()
                        UIApplication.shared().isNetworkActivityIndicatorVisible = false
                    })
                })
            }
            returncell = cell
        }
        return returncell
    }
    
    // MARK: UICollectionViewDelegate
    
   override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var size = CGSize.init(width: UIScreen.main().bounds.width, height: 300)
    if indexPath.row == 0 {
        size = CGSize.init(width: UIScreen.main().bounds.width, height: 70)
    }
    return size
    }
    
    
}

class SubscriptionsProfilePicCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var items = [UIImage]()
    
    //MARK: Methods
    
    func fetchImages()  {
        let _ = URLSession.shared().dataTask(with: globalVariables.subscriptionsLink) { (data, response, error) in
            if error != nil {
                print("Please check your internet connection")
            } else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String]
                    for item in json {
                        let link = URL.init(string: item)!
                        let data = try Data.init(contentsOf: link)
                        let image = UIImage.init(data: data)
                        self.items.append(image!)
                    }
                } catch _ {
                    print("error fetching the feed")
                }
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            }
            }.resume()
    }
    
    //MARK: CollectionView delegates and datasources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePic", for: indexPath)
        let profileImage = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 50, height: 50))
        profileImage.image = self.items[indexPath.row]
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true
        cell.contentView.addSubview(profileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 70, height: 70)
        return size
    }
    
    
    //MARK: Inits
    
    override func awakeFromNib() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ProfilePic")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        fetchImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}





