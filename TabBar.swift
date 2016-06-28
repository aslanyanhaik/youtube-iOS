//
//  TabBar.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/26/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class TabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    //MARK: Properties
    
    let identifier = "cell"
    let darkItems = ["homeDark", "trendingDark", "subscriptionsDark", "accountDark"]
    let items = ["home", "trending", "subscriptions", "account"]
    
    lazy var collectionView: UICollectionView  = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear()
        return cv
        
    }()
    
    
  
    //MARK: CollectionView DataSources
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TabBarCellCollectionViewCell
        cell.backgroundColor = UIColor.clear()
        cell.icon.image = UIImage.init(named: darkItems[indexPath.row])
        
        if indexPath.row == 0 {
            cell.icon.image = UIImage.init(named: items[0])
            
        }
        
       
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: self.frame.width / 4, height: self.frame.height)
        
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        for index in  0...3 {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as! TabBarCellCollectionViewCell
            cell.icon.image = UIImage.init(named: darkItems[index])
            
        }

        let cell = collectionView.cellForItem(at: indexPath) as! TabBarCellCollectionViewCell
        cell.icon.image = UIImage.init(named: items[indexPath.row])

        
    }
    
   
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(TabBarCellCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        addSubview(collectionView)
        
        

        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
