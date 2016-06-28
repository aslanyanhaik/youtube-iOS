//
//  CustomCollectionViewCell.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/23/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

    class CustomCollectionViewCell: UICollectionViewCell {
    
        
    //MARK: Properties
        
    
    @IBOutlet weak var profilePic: UIButton!
    @IBOutlet weak var videoPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var separatorView: SeparatorView!
    
   
    //MARK: Inits
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePic.layer.cornerRadius = 24
        self.profilePic.clipsToBounds  = true

        
        
    }
        
        
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
    }
        
        

        
  }
