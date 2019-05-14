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

class MainViewController: UIViewController {
  
  //MARK: IBOutlets
  @IBOutlet var tabBarView: TabBarView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: Properties
  lazy var controllers: [UIViewController] = {
    //    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
    //    let trendingVC = self.storyboard?.instantiateViewController(withIdentifier: "TrendingVC")
    //    let subscriptionsVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionsVC")
    //    let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC")

  }()

  //MARK: ViewController lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

//MARK: Private methods
extension MainViewController {
  
  func customization() {
    tabBarView.delegate = self
  }
}

//MARK: Tabbar delegate
extension MainViewController: TabBarViewDelegate {
  func tabBar(didSelect index: Int) {
    
  }
}
  
//  func customization()  {
//
//
//    //ViewController init
//    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
//    let trendingVC = self.storyboard?.instantiateViewController(withIdentifier: "TrendingVC")
//    let subscriptionsVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionsVC")
//    let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC")
//    let viewControllers = [homeVC, trendingVC, subscriptionsVC, accountVC]
//    for vc in viewControllers {
//      self.addChild(vc!)
//      vc!.didMove(toParent: self)
//      vc!.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
//      self.views.append(vc!.view)
//    }
//    self.collectionView.reloadData()
//    //NotificationCenter setup
//    NotificationCenter.default.addObserver(self, selector: #selector(self.scrollViews(notification:)), name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(self.hideBar(notification:)), name: NSNotification.Name("hide"), object: nil)
//  }
  
}


/*
 
 
 class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 //MARK: Properties
 var views = [UIView]()
 
 //MARK: Methods
 
 
 @objc func scrollViews(notification: Notification) {
 if let info = notification.userInfo {
 let userInfo = info as! [String: Int]
 self.collectionView.scrollToItem(at: IndexPath.init(row: userInfo["index"]!, section: 0), at: .centeredHorizontally, animated: true)
 }
 }
 
 @objc func hideBar(notification: NSNotification)  {
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
 

 */
