//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class TrendingCollectionViewController: FeedCollectionViewController {
    
    //MARK: - Properties
    override var downloadURL: URL {
        get {
            return globalVariables.moreURLLink
        }
        set {}
    }
    
    override var moreDownloadURL: URL {
        get {
            return globalVariables.urlLink
        }
        set {}
    }
    
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Top", for: indexPath) as! TrendingItemsCell
            returncell = cell
        } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
                cell.resetCell()
                if let video = videoItems[indexPath.row - 1] {
                    cell.setupCell(videoItem: video)
                } else{
                    VideoItem.object(at: (indexPath.row - 1), fromList: itemsList, completiotion: { (video, index) in
                        self.videoItems[index] = video
                        DispatchQueue.main.async(execute: {
                            self.collectionView?.reloadData()
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        })
                    })
                }
                returncell = cell
        }
        return returncell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if indexPath.row == 0 {
            size = CGSize.init(width: UIScreen.main.bounds.width, height: 100)
        } else {
        size = CGSize.init(width: UIScreen.main.bounds.width, height: 300)
        }
        return size
    }
    
}

//MARK TopCellClass
class TrendingItemsCell: UICollectionViewCell {
    
    @IBOutlet var buttons: [UIButton]!
    
    func roundCorners()  {
        for button in self.buttons {
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
        }
    }
    
    //MARK: Inits
    override func awakeFromNib() {
        roundCorners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
