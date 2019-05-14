//
//  TabBarView.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

class TabBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

/*
 
 class TabBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
 
 //MARK: Properties
 @IBOutlet weak var collectionView: UICollectionView!
 @IBOutlet weak var whiteBar: UIView!
 @IBOutlet weak var whiteBarLeadingConstraint: NSLayoutConstraint!
 private let tabBarImages = ["home", "trending", "subscriptions", "account"]
 var selectedIndex = 0
 
 //MARK: Methods
 func customization() {
 self.collectionView.delegate = self
 self.collectionView.dataSource = self
 self.backgroundColor = UIColor.rbg(r: 228, g: 34, b: 24)
 NotificationCenter.default.addObserver(self, selector: #selector(self.animateMenu(notification:)), name: Notification.Name.init(rawValue: "scrollMenu"), object: nil)
 }
 
 @objc func animateMenu(notification: Notification) {
 if let info = notification.userInfo {
 let userInfo = info as! [String: CGFloat]
 self.whiteBarLeadingConstraint.constant = self.whiteBar.bounds.width * userInfo["length"]!
 self.selectedIndex = Int(round(userInfo["length"]!))
 self.layoutIfNeeded()
 self.collectionView.reloadData()
 }
 }
 
 //MARK: Delegates
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return self.tabBarImages.count
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TabBarCellCollectionViewCell
 var imageName = self.tabBarImages[indexPath.row]
 if self.selectedIndex == indexPath.row {
 imageName += "Selected"
 }
 cell.icon.image = UIImage.init(named: imageName)
 return cell
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 return CGSize.init(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
 }
 
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 if self.selectedIndex != indexPath.row {
 self.selectedIndex = indexPath.row
 NotificationCenter.default.post(name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": self.selectedIndex])
 }
 }
 
 //MARK: View LifeCycle
 override func awakeFromNib() {
 super.awakeFromNib()
 self.customization()
 }
 
 deinit {
 NotificationCenter.default.removeObserver(self)
 }
 }
 
 //TabBarCell Class
 class TabBarCellCollectionViewCell: UICollectionViewCell {
 @IBOutlet weak var icon: UIImageView!
 }
 
 */
