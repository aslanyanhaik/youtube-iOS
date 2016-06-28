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
    
    let titles =  ["Hello there", "Hello there my name is Haik Aslanyan and I'm a developer, fdgafg adf gad fgad f", "Apple", "WWDC", "Steve Jobs", "sdgsdg"]
    
    
    //MARk: - Methods
    
    
    func customization()  {
        
        //CollectionView Customization
        
        self.collectionView?.backgroundColor = UIColor.white()
        self.collectionView?.contentInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.height)!, 0, 0, 0)
        
        //NavigationBar customization
        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "search_icon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainCollectionViewController.handleSearch))
        searchButton.tintColor = UIColor.white()
        self.navigationItem.rightBarButtonItems = [searchButton]
        self.navigationController?.navigationBar.barTintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        let title = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.white()
        title.text = "Home"
        self.navigationController?.navigationBar.addSubview(title)
        let moreButton = UIBarButtonItem.init(image: UIImage.init(named: "nav_more_icon"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        moreButton.tintColor = UIColor.white()
        self.navigationItem.rightBarButtonItems?.insert(moreButton, at: 0)
        

    }
    
    
    func handleSearch()  {
        print(123)
        
        
    }
    
    //MARK: -  ViewController Lifecylce
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        
        let tabBar = TabBar.init(frame: CGRect.init(x: 0, y: self.navigationController!.navigationBar.frame.height + 20, width: self.navigationController!.navigationBar.frame.width, height: self.navigationController!.navigationBar.frame.height))
        tabBar.backgroundColor = UIColor.rbg(r: 228, g: 34, b: 24)
        self.view.addSubview(tabBar)
     
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return titles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.videoPic.image = UIImage.init(named: "San Francisco")
        cell.videoDescription.text = "Hello there"
        let text = titles[indexPath.row] as NSString
        
        if text.length > 27  {
           let shortText =  text.substring(to: 27) + ". . .more"
            cell.videoTitle.text = shortText as String

        } else{
            cell.videoTitle.text = text as String

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
        
        if indexPath.row == (self.titles.count - 1) {
            cell.subviews[0].subviews[0].isHidden = true
        }
        
    }
    
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
