//
//  SubscriptionsViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*

class SubscriptionsVC: HomeVC {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.videos.count + 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionsCell") as! SubscriptionsCell
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
      cell.set(video: self.videos[indexPath.row - 1])
      return cell
    }
  }
}

//TableView Custom Classes
class SubscriptionsCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var channels = [Channel]()
  
  func customization() {
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    Channel.fetchData { [weak self] channels in
      guard let weakSelf = self else {
        return
      }
      weakSelf.channels = channels
      weakSelf.collectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.channels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Channel", for: indexPath) as! SubscriptionsCVCell
    cell.channelPic.image = self.channels[indexPath.row].image
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 50, height: 50)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.customization()
  }
}

class SubscriptionsCVCell: UICollectionViewCell {
  @IBOutlet weak var channelPic: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.channelPic.layer.cornerRadius = 25
    self.channelPic.clipsToBounds = true
  }
  
  
}
 */
