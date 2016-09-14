//
//  Profile.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/11/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    //MARK: Properties
    let name: String
    let profilePic: UIImage
    let backgroundImage: UIImage
    let playlists: Array<Playlist>

    
    //MARK: Methods
    class func fetchProfile(link: URL, completition: @escaping ((User) -> Void)) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let _ =  URLSession.shared.dataTask(with: link) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    let name = json["name"] as! String
                    let profilePic = UIImage.contentOfURL(link: (json["profilePic"] as! String))
                    let backgroundImage = UIImage.contentOfURL(link: (json["backgroundImage"] as! String))
                    var playlists = [Playlist]()
                        let list  = json["playlists"] as! [[String : AnyObject]]
                        for item in list {
                            let numberOfItems = item["numberOfVideos"] as! Int
                            let title = item["title"] as! String
                            let pic = UIImage.contentOfURL(link: item["pic"] as! String)
                            let playlistItem = Playlist.init(pic: pic, title: title, numberOfVideos: numberOfItems)
                            playlists.append(playlistItem)
                        }
                    let user = User.init(name: name, profilePic: profilePic, backgroundImage: backgroundImage, playlists: playlists)
                    completition(user)
                } catch _ {
                        showNotification()
}
            } else {
                showNotification()
            }
        }.resume()
    }
    
    //MARK: Inits
    init(name: String, profilePic: UIImage, backgroundImage: UIImage, playlists: Array<Playlist>) {
        self.profilePic = profilePic
        self.backgroundImage = backgroundImage
        self.playlists = playlists
        self.name = name
    }
    
}
