//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SelectedCell  {
    
    //MARK: - Properties
    
    var itemsList = [[String : AnyObject]] ()
    
    var videoCache = Cache<NSNumber, Video>()
    
    var darkView: UIView = {
        let dv =  UIView.init(frame: UIScreen.main().bounds)
        dv.backgroundColor = UIColor.black()
        dv.alpha = 0
        return dv
    }()
    
    lazy var settings: Settings = {
        let st = Settings.init(frame: CGRect.init(x: 0, y: UIScreen.main().bounds.height, width: UIScreen.main().bounds.width, height: 288))
        return st
    
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white()
        tl.text = "Home"
        return tl
    }()
    
    var tabBar: TabBar?
    
    //MARK: - Methods
    
    
    
    func customization()  {
        
        //CollectionView Customization
        self.collectionView?.backgroundColor = UIColor.white()
        self.collectionView?.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        
        //DarkView

        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(MainCollectionViewController.dismissDarkView))
        self.darkView.addGestureRecognizer(singleTap)
        
        
        //Settings Table 
        
        

        
        //NavigationBar customization
        
            //NavigationBar color
        
        self.navigationController?.navigationBar.barTintColor = UIColor.rbg(r: 228, g: 34, b: 24)

            // Buttons
        
        let searchButton: UIBarButtonItem = {
            let sb = UIBarButtonItem.init(image: UIImage.init(named: "search_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainCollectionViewController.handleSearch))
            sb.tintColor = UIColor.white()
            return sb
        }()
        
        let moreButton: UIBarButtonItem = {
            let  mb = UIBarButtonItem.init(image: UIImage.init(named: "nav_more_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainCollectionViewController.more))
            mb.tintColor = UIColor.white()
            return mb
        }()
        
        self.navigationItem.rightBarButtonItems = [moreButton, searchButton]
        
            // TitleBabel
        
        self.navigationController?.navigationBar.addSubview(titleLabel)

            //TabBar
        
        self.tabBar = TabBar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: (self.navigationController?.navigationBar.frame.height)!))
        self.view.addSubview(self.tabBar!)
        
            //Navbar Shadow
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //StatusBar background color
        
        let statusBarBackgroundView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 20))
        statusBarBackgroundView.backgroundColor = UIColor.black().withAlphaComponent(0.2)
        self.navigationController?.view.addSubview(statusBarBackgroundView)
        
    }
    
    
    func handleSearch()  {


        
    }
    
    
    func dismissDarkView(andPush: Bool = false)  {
        UIView.animate(withDuration: 0.3,
                       animations: {self.darkView.alpha = 0
            self.settings.frame.origin.y = (UIApplication.shared().keyWindow?.frame.height)!})
        { (true) in self.darkView.removeFromSuperview()
                    self.settings.removeFromSuperview()
            if andPush == true {
                self.navigationController?.pushViewController(UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Second"), animated: true)            }
            
        }
        
    }
    
    
    
    func more()  {
        
        if let window = UIApplication.shared().keyWindow {
            window.addSubview(self.darkView)
            window.addSubview(self.settings)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.darkView.alpha = 0.5
        })
        
        UIView.animate(withDuration: 0.3, animations: {
           self.settings.frame.origin.y -= 288
        })

    }
    
    
    //MARK Settings Table delegate
    
    func cellInfoAtIndex(index: Int) {
        switch index {
        case 0:
            dismissDarkView(andPush: true)
            
        default:
            dismissDarkView()
        }

    }
    
   
    
    //MARK: -  ViewController Lifecylce
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        Video.getVideosList(fromURL: globalVariables.urlLink) { (items) -> (Void) in
            
            self.itemsList = items
            self.videoCache.countLimit = items.count
            
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                UIApplication.shared().isNetworkActivityIndicatorVisible = false
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.settings.delegate = self

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
       // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.itemsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
            if itemsList.isEmpty == false {
                if videoCache.object(forKey: indexPath.row as NSNumber) != nil {
                    let videoItem = self.videoCache.object(forKey: indexPath.row as NSNumber)!
                    cell.videoPic.image = videoItem.tumbnail
                    cell.videoTitle.text = videoItem.title
                    cell.channelPic.setImage(videoItem.channel.image, for: [])
                    cell.channelPic.imageView?.contentMode = UIViewContentMode.scaleAspectFill
                    cell.videoDuration.text = " " + secondsToHoursMinutesSeconds(seconds: videoItem.duration) + " "
                    let viewsCount = NumberFormatter()
                    viewsCount.numberStyle = .decimal
                    let views = viewsCount.string(from: videoItem.views as NSNumber)!
                    let description = videoItem.channel.name + "  • " + views
                    cell.videoDescription.text = description
                } else{
                    Video.object(at: indexPath.row, fromList: itemsList, completiotion: { (videoItem, index) in
                        
                        self.videoCache.setObject(videoItem, forKey: indexPath.row as NSNumber)
                        if indexPath.row == index {
                            DispatchQueue.main.async(execute: {
                                cell.videoPic.image = videoItem.tumbnail
                                cell.videoTitle.text = videoItem.title
                                cell.channelPic.setImage(videoItem.channel.image, for: [])
                                cell.channelPic.imageView?.contentMode = UIViewContentMode.scaleAspectFill
                                cell.videoDuration.text = " " + secondsToHoursMinutesSeconds(seconds: videoItem.duration) + " "
                                let viewsCount = NumberFormatter()
                                viewsCount.numberStyle = .decimal
                                let views = viewsCount.string(from: videoItem.views as NSNumber)!
                                let description = videoItem.channel.name + "  • " + views
                                cell.videoDescription.text = description
                            })
                        }
                    })
                }
        }
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize.init(width: self.view.bounds.width, height: 300)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == (self.itemsList.count - 1) {
            cell.subviews[0].subviews[0].isHidden = true
        }
        
    }
    
    
   }
