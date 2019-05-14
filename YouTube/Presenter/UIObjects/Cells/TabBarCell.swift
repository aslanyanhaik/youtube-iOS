//
//  TabBarCell.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

class TabBarCell: UICollectionViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  
  func set(image: UIImage?, setSelected: Bool) {
    iconImageView.image = image
    iconImageView.tintColor = setSelected ? .white : ThemeService.darkRedColor
  }
}
