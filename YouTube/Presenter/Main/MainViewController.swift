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
  lazy var nestedViews: [UIView] = {
    let homeVC: HomeViewController = UIStoryboard.controller(storyboard: .pages)
    let trendingVC: TrendingViewController = UIStoryboard.controller(storyboard: .pages)
    let subscriptionsVC: SubscriptionsViewController = UIStoryboard.controller(storyboard: .pages)
    let accountVC: ProfileViewController = UIStoryboard.controller(storyboard: .pages)
    let controllers = [homeVC, trendingVC, subscriptionsVC, accountVC]
    controllers.forEach({ controller in
      self.addChild(controller)
      controller.didMove(toParent: self)
    })
    return controllers.map({$0.view})
  }()

  //MARK: ViewController lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    customization()
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
    collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
  }
}

//MARK: UICollectionView delegate & datasource
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return nestedViews.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.addSubview(nestedViews[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let scrollIndex = scrollView.contentOffset.x / view.bounds.width
    tabBarView.animate(offset: scrollIndex)
  }
}
