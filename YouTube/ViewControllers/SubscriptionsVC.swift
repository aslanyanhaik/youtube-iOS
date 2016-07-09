//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class SubscriptionsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    var itemsList = [[String : AnyObject]] ()
    var videoItems = [Int : Video]()
    let refresh = UIRefreshControl()
    
    
    //MARK: Methods
    func refreshContent()  {
        self.videoItems.removeAll()
        fetchItemsList()
    }
    
    func fetchItemsList() {
        Video.getVideosList(fromURL: globalVariables.urlLink) { (items) -> (Void) in
            self.itemsList = items
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                UIApplication.shared().isNetworkActivityIndicatorVisible = false
                self.refresh.endRefreshing()
            })
        }
    }
    
    func customization() {
        
        //CollectionView customization
        self.collectionView?.contentInset = UIEdgeInsetsMake(21, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(21, 0, 0, 0)
        
        //Refresh Control
        refresh.addTarget(self, action: #selector(SubscriptionsCollectionViewController.refreshContent), for: UIControlEvents.valueChanged)
        self.refresh.tintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        self.collectionView?.addSubview(self.refresh)
    }
    
    //MARK: -  ViewController Lifecylce
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        fetchItemsList()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.resetCell()
        if let video = videoItems[indexPath.row] {
            cell.setupCell(videoItem: video)
        } else{
            Video.object(at: indexPath.row, fromList: itemsList, completiotion: { (video, index) in
                self.videoItems[index] = video
                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                    UIApplication.shared().isNetworkActivityIndicatorVisible = false
                })
            })
        }
        if indexPath.row == (self.itemsList.count - 1) {
            cell.separatorView.isHidden = true
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize.init(width: UIScreen.main().bounds.width, height: 300)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
