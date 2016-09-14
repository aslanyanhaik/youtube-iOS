//
//  Video.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/26/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import Foundation
import UIKit

class Video {
    
    //MARK: Properties
    let videoLink: URL
    let title: String
    let viewCount: Int
    let likes: Int
    let disLikes: Int
    let channelTitle: String
    let channelPic: UIImage
    let channelSubscribers: Int
    var suggestedVideos = [SuggestedVideo]()
    
    //MARK: Inits
    init(videoLink: URL, title: String, viewCount: Int, likes: Int, disLikes: Int, channelTitle: String, channelPic: UIImage, channelSubscribers: Int, suggestedVideos: [SuggestedVideo]) {
        self.videoLink = videoLink
        self.title = title
        self.viewCount = viewCount
        self.likes = likes
        self.disLikes = disLikes
        self.channelTitle = channelTitle
        self.channelPic = channelPic
        self.channelSubscribers = channelSubscribers
        self.suggestedVideos = suggestedVideos
    }
    
    //MARK: Methods
    class func download(link: URL, completiotion: @escaping ((Video) -> Void))  {
        URLSession.shared.dataTask(with: link) { (data, _, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    let videoLink = URL.init(string: (json["videoLink"] as! String))
                    let title = json["title"] as! String
                    let viewCount = json["viewCount"] as! Int
                    let likes = json["likes"] as! Int
                    let disLikes = json["disLikes"] as! Int
                    let channelTitle = json["channelTitle"] as! String
                    let channelPic = UIImage.contentOfURL(link: (json["channelPic"] as! String))
                    let channelSubscribers = json["channelSubscribers"] as! Int
                    let suggestedVideosList = json["suggestedVideos"] as! [[String : String]]
                    var suggestedVideos = [SuggestedVideo]()
                    for item in suggestedVideosList {
                        let videoTitle = item["title"]!
                        let thumbnail = UIImage.contentOfURL(link: item["thumbnail_image_name"]!)
                        let name = item["name"]!
                        let suggestedItem = SuggestedVideo.init(title: videoTitle, name: name, thumbnail: thumbnail)
                        suggestedVideos.append(suggestedItem)
                    }
                    let video = Video.init(videoLink: videoLink!,
                                               title: title,
                                            viewCount: viewCount,
                                                likes: likes,
                                                disLikes: disLikes,
                                                channelTitle: channelTitle,
                                                channelPic: channelPic,
                                                channelSubscribers: channelSubscribers,
                                                suggestedVideos: suggestedVideos)
                    completiotion(video)
                } catch _ {
                    showNotification()
                }
            }
        }.resume()
    }
    
}
