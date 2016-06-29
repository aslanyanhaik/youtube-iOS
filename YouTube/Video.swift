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
    
    
    //MARK: download and parsing
    
    
   class func getVideos(fromURL: URL, completition: ([Video]) -> (Void)) {
    
        UIApplication.shared().isNetworkActivityIndicatorVisible = true
        var itemsArray = [Video]()
        URLSession.shared().dataTask(with: fromURL) { (data, response, error) in
            if error != nil {
            print("Please check your internet connection")
            } else{
            
                
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        let items = json as! [[String : AnyObject]]
                        
                        for item in items{
                            
                            let title  = item["title"] as! String
                            let tumbnail = UIImage.contentOfURL(link: item["thumbnail_image_name"] as! String)
                            let views = item["number_of_views"] as! Int
                            let duration = item["duration"] as! Int
                            let channelDic = item["channel"] as! [String : String]
                            let channelPic = UIImage.contentOfURL(link: channelDic["profile_image_name"]!)
                            let channelName = channelDic["name"]!
                            
                            let channel = Channel.init(name: channelName, image: channelPic)
                            let video = Video.init(title: title, tumbnail: tumbnail, views: views, duration: duration, channel: channel)
                            
                            itemsArray.append(video)
                            
                        }
                     completition(itemsArray)
                        
                    } catch _ {
                    print("error fetching the feed")
                    }
                }
            
        }.resume()

    }
    
    
    //MARK: Inits

    init(title: String, tumbnail: UIImage, views: Int, duration: Int, channel: Channel) {
        self.title = title
        self.views = views
        self.tumbnail = tumbnail
        self.channel = channel
        self.duration = duration
    
    }
}
