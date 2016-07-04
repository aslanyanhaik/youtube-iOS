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
    lazy var whiteView: UIView = {
        let wv = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 3, width: self.frame.width / 4, height: 3))
        wv.backgroundColor = UIColor.rbg(r: 245, g: 245, b: 245)
        return wv
    }()
    
    lazy var collectionView: UICollectionView  = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: globalVariables.rect, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear()
        return cv
        
    }()
    
    
  
    //MARK: CollectionView DataSources
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TabBarCellCollectionViewCell
        cell.icon.image = UIImage.init(named: darkItems[indexPath.row])
        
        if indexPath.row == 0 {
            cell.icon.image = UIImage.init(named: items[0])
            
        }
        
       
        return cell

    }
    
    //MARK: CollectionView Delegates

    
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
        
        UIView.animate(withDuration: 0.2, animations: {
            self.whiteView.frame.origin.x = self.frame.width / 4 * CGFloat(indexPath.row)
        })
        
    }
    
   
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(TabBarCellCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        self.backgroundColor = UIColor.rbg(r: 228, g: 34, b: 24)
        addSubview(self.collectionView)
        addSubview(self.whiteView)
                
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



//TabBarCell Class

class TabBarCellCollectionViewCell: UICollectionViewCell {
    
    
    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear()
        let height = (self.contentView.frame.height - 40) / 2
        let width = (self.contentView.frame.width - 30) / 2
        icon.frame = CGRect.init(x: width, y: height, width: 30, height: 30)
        let image = UIImage.init(named: "home")
        icon.image = image?.withRenderingMode(.alwaysTemplate)
        self.contentView.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
