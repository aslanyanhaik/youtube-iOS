//
//  MainViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/6/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, hideSettings, hideSearch, TabBarDelegate   {
    
    
    //MARK: Properties
    
    let identifier = "cell"
    var items = [UIView]()
    
     lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main().bounds.width, height: (self.view.bounds.height)), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear()
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.isDirectionalLockEnabled = true
        return cv
    }()
    
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
    
    //MARK: Methods
    
    func viewControllersInits()  {
        let storyBoard = self.storyboard!
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        self.addChildViewController(homeVC)
        homeVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
        homeVC.didMove(toParentViewController: self)
        self.items.append(homeVC.view)
        let trendingVC = storyBoard.instantiateViewController(withIdentifier: "Trending")
        self.addChildViewController(trendingVC)
        trendingVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
        trendingVC.didMove(toParentViewController: self)
        self.items.append(trendingVC.view)
        
        let subscriptionsVC = storyBoard.instantiateViewController(withIdentifier: "Subscriptions")
        self.addChildViewController(trendingVC)
        subscriptionsVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
        subscriptionsVC.didMove(toParentViewController: self)
        self.items.append(subscriptionsVC.view)
        
        let accountVC = storyBoard.instantiateViewController(withIdentifier: "Account")
        self.addChildViewController(accountVC)
        accountVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
        accountVC.didMove(toParentViewController: self)
        self.items.append(accountVC.view)

        
    }
    
    
    func customization()  {
        
        //CollectionView Customization
        self.collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        
        
        //NavigationController Customization
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
            let sb = UIBarButtonItem.init(image: UIImage.init(named: "search_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainViewController.handleSearch))
            sb.tintColor = UIColor.white()
            return sb
        }()
        
        let moreButton: UIBarButtonItem = {
            let  mb = UIBarButtonItem.init(image: UIImage.init(named: "nav_more_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainViewController.handleMore))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        self.settings.delegate = self
        self.search.delegate = self
        self.tabBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        customization()
        viewControllersInits()
    }


    
    
    
    //MARK: CollectionView DataSources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.contentView.addSubview(self.items[indexPath.row])
        return cell
        
    }
    
    //MARK: CollectionView Delegates
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: self.view.bounds.width, height: (self.view.bounds.height + 22))
        
    }
    
    
}



