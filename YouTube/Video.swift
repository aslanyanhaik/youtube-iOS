//
//  Video.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/27/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import Foundation
import UIKit


class Video {
    
    //MARK: Properties
    
    let tumbnail: UIImage
    let title: String
    let views: Int
    let channel: Channel
    let duration: Int
    
    
    //MARK: Inits

    init(title: String, tumbnail: UIImage, views: Int, duration: Int, channel: Channel) {
        self.title = title
        self.views = views
        self.tumbnail = tumbnail
        self.channel = channel
        self.duration = duration
    
    }
}
