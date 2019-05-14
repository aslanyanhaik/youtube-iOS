//  MIT License

//  Copyright (c) 2019 Haik Aslanyan

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

protocol TabBarViewDelegate: class {
  
  func tabBar(didSelect index: Int)
  
}


class TabBarView: UIView {
  
  //MARK: IBOutlets
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var whiteBar: UIView!
  @IBOutlet weak var whiteBarLeadingConstraint: NSLayoutConstraint!
  
  //MARK: Properties
  public var delegate: TabBarViewDelegate?
  private let tabBarImages = ["home", "trending", "subscriptions", "account"]
  private var selectedIndex = 0
  
  //MARK: View lifeCycle
  override func awakeFromNib() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
  }
//
//  @objc func animateMenu(notification: Notification) {
//    if let info = notification.userInfo {
//      let userInfo = info as! [String: CGFloat]
//      self.whiteBarLeadingConstraint.constant = self.whiteBar.bounds.width * userInfo["length"]!
//      self.selectedIndex = Int(round(userInfo["length"]!))
//      self.layoutIfNeeded()
//      self.collectionView.reloadData()
//    }
//  }
  
}

//MARK: UICollectionView datasource & delegate
extension TabBarView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabBarImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCell.className, for: indexPath) as! TabBarCell
    cell.set(image: UIImage(named: tabBarImages[indexPath.row]), setSelected: indexPath.row == selectedIndex)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard selectedIndex != indexPath.row else { return }
    selectedIndex = indexPath.row
    delegate?.tabBar(didSelect: indexPath.row)
  }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.bounds.width / CGFloat(tabBarImages.count), height: collectionView.bounds.height)
  }
}

