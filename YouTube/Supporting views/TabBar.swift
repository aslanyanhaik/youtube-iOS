//
//  TabBar.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/26/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

protocol TabBarDelegate {
    func didSelectItem(atIndex: Int)
}

import UIKit
class TabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: Properties
    let identifier = "cell"
    let darkItems = ["homeDark", "trendingDark", "subscriptionsDark", "accountDark"]
    let items = ["home", "trending", "subscriptions", "account"]
    lazy var whiteView: UIView = {
        let wv = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 5, width: self.frame.width / 4, height: 5))
        wv.backgroundColor = UIColor.rbg(r: 245, g: 245, b: 245)
        return wv
    }()
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: CGRect.init(x: 0, y: 20, width: self.frame.width, height: (self.frame.height - 20)), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        cv.isScrollEnabled = false
        return cv
    }()
    var delegate: TabBarDelegate?
    
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
        return CGSize.init(width: self.frame.width / 4, height: (self.frame.height - 20))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(atIndex: indexPath.row)
    }
    
    //MARK: Methods
    func highlightItem(atIndex: Int)  {
        for index in  0...3 {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as! TabBarCellCollectionViewCell
            cell.icon.image = UIImage.init(named: darkItems[index])
        }
        let cell = collectionView.cellForItem(at: IndexPath.init(row: atIndex, section: 0)) as! TabBarCellCollectionViewCell
        cell.icon.image = UIImage.init(named: items[atIndex])
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
        self.backgroundColor = UIColor.clear
        let width = (self.contentView.bounds.width - 30) / 2
        icon.frame = CGRect.init(x: width, y: 2, width: 30, height: 30)
        let image = UIImage.init(named: "home")
        icon.image = image?.withRenderingMode(.alwaysTemplate)
        self.contentView.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
