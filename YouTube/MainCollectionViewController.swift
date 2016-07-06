//
//  MainCollectionViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/22/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, hideSettings, hideSearch, TabBarDelegate {
    
    //MARK: - Properties
    
    var itemsList = [[String : AnyObject]] ()
    var videoItems = [Int : Video]()
    let tabBar: TabBar = {
        let tb = TabBar.init(frame: CGRect.init(x: 0, y: 0, width: globalVariables.width, height: 64))
        return tb
    }()
    let statusView: UIView = {
       let st = UIView.init(frame: CGRect.init(x: 0, y: 0, width: globalVariables.width, height: 20))
        st.backgroundColor = UIColor.black()
        st.alpha = 0.3
        return st
    }()
    let settings: Settings = {
       let st = Settings.init(frame: UIScreen.main().bounds)
        return st
    }()
    let search: Search = {
        let se = Search.init(frame: UIScreen.main().bounds)
        return se
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white()
        tl.text = "Home"
        return tl
    }()
    
    //MARK: - Methods
    
    func customization()  {
        
        //CollectionView Customization
        self.collectionView?.backgroundColor = UIColor.white()
        self.collectionView?.contentInset = UIEdgeInsetsMake(self.tabBar.frame.height, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(self.tabBar.frame.height, 0, 0, 0)
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.view.backgroundColor = UIColor.rbg(r: 228, g: 34, b: 24)
        
        //StaturBar background View
        
        if let window  = UIApplication.shared().keyWindow {
            window.addSubview(self.statusView)
        }
        
        //NavigationBar customization
        
            //NavigationBar color and shadow
        
        self.navigationController?.navigationBar.barTintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

            // Buttons
        
        let searchButton: UIBarButtonItem = {
            let sb = UIBarButtonItem.init(image: UIImage.init(named: "search_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainCollectionViewController.handleSearch))
            sb.tintColor = UIColor.white()
            return sb
        }()
        
        let moreButton: UIBarButtonItem = {
            let  mb = UIBarButtonItem.init(image: UIImage.init(named: "nav_more_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainCollectionViewController.handleMore))
            mb.tintColor = UIColor.white()
            return mb
        }()
        
        self.navigationItem.rightBarButtonItems = [moreButton, searchButton]
        
            // TitleBabel
        
        self.navigationController?.navigationBar.addSubview(self.titleLabel)

            //TabBar
        
        self.view.addSubview(self.tabBar)
    }

    
    
    //MARK: Search and Settings
    
    func handleSearch()  {
        if let window = UIApplication.shared().keyWindow {
            window.insertSubview(self.search, belowSubview: self.statusView)
            self.search.animate()
        }
        
    }
    
    func handleMore()  {
        if let window = UIApplication.shared().keyWindow {
            window.addSubview(self.settings)
            self.settings.animate()
        }
    }
    
    //MARK: Delegates implementation
    
    func didSelectItem(atIndex: Int) {
        switch atIndex {
        case 0:
            self.titleLabel.text = "Home"
        case 1:
            self.titleLabel.text = "Trending"
        case 2:
            self.titleLabel.text = "Subscriptions"
        case 3:
            self.titleLabel.text = "Account"
        default: break
        }
    }

    func hideSettingsView(status: Bool) {
        if status == true {
            self.settings.removeFromSuperview()
        }
    }
    
    func hideSearchView(status : Bool){
        if status == true {
            self.search.removeFromSuperview()
        }
    }

    
    //MARK: -  ViewController Lifecylce
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        Video.getVideosList(fromURL: globalVariables.urlLink) { (items) -> (Void) in
            self.itemsList = items
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                UIApplication.shared().isNetworkActivityIndicatorVisible = false
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.settings.delegate = self
        self.search.delegate = self
        self.tabBar.delegate = self
        
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
        
        
        let size = CGSize.init(width: self.view.bounds.width, height: 300)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
    
   }
