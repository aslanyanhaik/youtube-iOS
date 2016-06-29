//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    var items = [Video]()
    
    
    var titleLabel: UILabel = {
        let tl = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white()
        tl.text = "Home"
        return tl
    }()
    

    
    var tabBar: TabBar?
    
    //MARk: - Methods
    
    
    func customization()  {
        
        //CollectionView Customization
        self.collectionView?.backgroundColor = UIColor.white()
        self.collectionView?.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        
        
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
    
    
    //MARK: Search and More functions
    
    
    func handleSearch()  {
        let aa = Video.init(title: "Taylor Swift", tumbnail: UIImage.init(named: "San Francisco")!, views: 15235235235, duration: 9, channel: Channel.init(name: "TaylorSwiftVevo", image: UIImage.init(named: "San Francisco")!))
        self.items.append(aa)
        self.collectionView?.reloadData()
        
    }
    
    
    func more()  {
        
    }
    
    //MARK: -  ViewController Lifecylce
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        Video.getVideos(fromURL: globalVariables.urlLink) { (videos) in
            
            self.items = videos

                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                    UIApplication.shared().isNetworkActivityIndicatorVisible = false
                })
        }
        
        
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
       // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.videoPic.image = items[indexPath.row].tumbnail
        cell.videoTitle.text = items[indexPath.row].title
        cell.channelPic.setImage(items[indexPath.row].channel.image, for: [])
        cell.channelPic.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        cell.videoDuration.text = " " + secondsToHoursMinutesSeconds(seconds: items[indexPath.row].duration) + " "
            let viewsCount = NumberFormatter()
            viewsCount.numberStyle = .decimal
            let views = viewsCount.string(from: items[indexPath.row].views as NSNumber)!
            let description = items[indexPath.row].channel.name + "  • " + views
        cell.videoDescription.text = description
        

        
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
        
        if indexPath.row == (self.items.count - 1) {
            cell.subviews[0].subviews[0].isHidden = true
        }
        
    }
    
    
   }
