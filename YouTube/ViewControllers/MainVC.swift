//
//  MainVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/18/17.
//  Copyright © 2017 Haik Aslanyan. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    @IBOutlet var tabBarView: TabBarView!
    @IBOutlet weak var collectionView: UICollectionView!
    var views = [UIView]()
    
    //MARK: Methods
    func customization()  {
        //CollectionView Setup
        self.collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.view.bounds.height))
        //TabbarView setup
        self.view.addSubview(self.tabBarView)
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
        let _ = NSLayoutConstraint.init(item: self.view, attribute: .top, relatedBy: .equal, toItem: self.tabBarView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.tabBarView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.tabBarView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        self.tabBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        //ViewController init
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
        let trendingVC = self.storyboard?.instantiateViewController(withIdentifier: "TrendingVC")
        let subscriptionsVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionsVC")
        let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC")
        let viewControllers = [homeVC, trendingVC, subscriptionsVC, accountVC]
        for vc in viewControllers {
            self.addChildViewController(vc!)
            vc!.didMove(toParentViewController: self)
            vc!.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
            self.views.append(vc!.view)
        }
        self.collectionView.reloadData()
        //NotificationCenter setup
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollViews(notification:)), name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideBar(notification:)), name: NSNotification.Name("hide"), object: nil)
    }
    
    func scrollViews(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Int]
            self.collectionView.scrollToItem(at: IndexPath.init(row: userInfo["index"]!, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func hideBar(notification: NSNotification)  {
        let state = notification.object as! Bool
        self.navigationController?.setNavigationBarHidden(state, animated: true)
    }
    
    //MARK: Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.addSubview(self.views[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.bounds.width, height: (self.collectionView.bounds.height + 22))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "scrollMenu"), object: nil, userInfo: ["length": scrollIndex])
    }
    
    //MARK: ViewController lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
