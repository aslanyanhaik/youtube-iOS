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
    @IBOutlet weak var channelPic: UIButton!
    @IBOutlet weak var videoPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoDuration: UILabel!
    @IBOutlet weak var separatorView: UIView!
       
   //MARK: Methods
    func customization()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.videoDuration.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.videoDuration.layer.borderWidth = 0.5
        self.videoDuration.layer.borderColor = UIColor.white.cgColor
        self.videoDuration.sizeToFit()
    }
        
    //MARK: Methods
    func resetCell()  {
        self.separatorView.isHidden = false
        self.videoPic.image = UIImage.init(named: "emptyTumbnail")
        self.videoTitle.text = ""
        self.channelPic.setImage(UIImage(), for: [])
        self.videoDuration.text = ""
        self.videoDescription.text = ""
    }
        
        func setupCell(videoItem: VideoItem)  {
        self.videoPic.image = videoItem.tumbnail
        self.videoTitle.text = videoItem.title
        self.channelPic.setImage(videoItem.channel.image, for: [])
        self.channelPic.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        self.videoDuration.text = " " + secondsToHoursMinutesSeconds(seconds: videoItem.duration) + " "
        let viewsCount = NumberFormatter()
        viewsCount.numberStyle = .decimal
        let views = viewsCount.string(from: videoItem.views as NSNumber)!
        let description = videoItem.channel.name + "  • " + views
        self.videoDescription.text = description
        }
        
    //MARK: Inits
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
    }
   
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
    }
        
  }
