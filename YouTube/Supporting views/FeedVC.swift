//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class FeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var itemsList = [[String : AnyObject]] ()
    var videoItems = [Int : VideoItem]()
    let refresh = UIRefreshControl()
    var lastContentOffset: CGFloat = 0.0
    internal var downloadURL = globalVariables.urlLink
    internal var moreDownloadURL = globalVariables.moreURLLink
    
    
    //MARK: Methods
    func customization() {
        
        //CollectionView customization
        self.collectionView?.contentInset = UIEdgeInsetsMake(21, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(21, 0, 0, 0)
        
        //Refresh Control
        refresh.addTarget(self, action: #selector(TrendingCollectionViewController.refreshContent), for: UIControlEvents.valueChanged)
        self.refresh.tintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        self.collectionView?.addSubview(self.refresh)
        
    }
    
    func refreshContent()  {
        self.videoItems.removeAll()
        fetchItemsList(link: downloadURL)
    }
    
    func fetchItemsList(link: URL) {
        VideoItem.getVideosList(fromURL: downloadURL) { (items) -> (Void) in
            self.itemsList += items
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.refresh.endRefreshing()
            })
        }
    }
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        fetchItemsList(link: downloadURL)
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
            VideoItem.object(at: (indexPath.row), fromList: itemsList, completiotion: { (video, index) in
                self.videoItems[index] = video
                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            })
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: UIScreen.main.bounds.width, height: 300)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            fetchItemsList(link: moreDownloadURL)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
}
