//
//  SubscriptionsProfilePicCell.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/11/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class SubscriptionsProfilePicCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var items = [UIImage]()
    
    //MARK: Methods
    func fetchImages()  {
        let _ = URLSession.shared.dataTask(with: globalVariables.subscriptionsLink) { (data, response, error) in
            if error != nil {
                print("Please check your internet connection")
            } else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String]
                    for item in json {
                        let image = UIImage.contentOfURL(link: item)
                        self.items.append(image)
                    }
                } catch _ {
                    print("error fetching the feed")
                }
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            }
            }.resume()
    }
    
    //MARK: CollectionView delegates and datasources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePic", for: indexPath) as! ProfilePic
        cell.profileImage.image = self.items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: 70, height: 70)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: Inits
    override func awakeFromNib() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        fetchImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


//MARK: Cell Class
class ProfilePic: UICollectionViewCell {
    
    //MARK: Properties
    let profileImage: UIImageView = {
        let pv = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 50, height: 50))
        pv.layer.cornerRadius = 25
        pv.clipsToBounds = true
        pv.backgroundColor = UIColor.gray
        return pv
    }()
    
    //MARK: Inits
    override func awakeFromNib() {
        self.addSubview(profileImage)
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}



