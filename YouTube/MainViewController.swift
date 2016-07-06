//
//  MainViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/6/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, hideSettings, hideSearch, TabBarDelegate {

    //MARK: Properties
    @IBOutlet weak var scrollview: UIScrollView!
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
    
    func customization()  {
   
        //ScrollVIew Customization
        self.scrollview.contentInset = UIEdgeInsetsMake(self.tabBar.frame.height, 0, 0, 0)
        self.scrollview.contentSize = CGSize.init(width: (UIScreen.main().bounds.width * 4), height: self.view.bounds.height)
        
        
        //NavigationController Customization
        self.scrollview.contentInset = UIEdgeInsetsMake(self.tabBar.frame.height, 0, 0, 0)
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
    
    
    func viewControllersInits()  {
        let storyBoard = self.storyboard!
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        print(homeVC.description)
        self.addChildViewController(homeVC)
        homeVC.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.scrollview.addSubview(homeVC.view)
        homeVC.didMove(toParentViewController: self)
        
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
        viewControllersInits()
        customization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.settings.delegate = self
        self.search.delegate = self
        self.tabBar.delegate = self
        
    }

}
