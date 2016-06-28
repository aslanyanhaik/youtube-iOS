//
//  TabBarCellCollectionViewCell.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/26/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class TabBarCellCollectionViewCell: UICollectionViewCell {
    
    
    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
