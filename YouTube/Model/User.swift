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
    var playlists = [Playlist]()

    //MARK: Methods
    class func fetchData(completion: @escaping ((User) -> Void)) {
        //Dummy Data
        let data = ["pl-swift": "Swift Tutorials", "pl-node": "NodeJS Tutorials", "pl-javascript": "JavaScript ES6 / ES2015 Tutorials", "pl-angular": "Angular 2 Tutorials", "pl-rest": "REST API Tutorials (Node, Express & Mongo)", "pl-react": "React development", "pl-mongo": "Mongo db"]
        let user = User.init(name: "Haik Aslanyan", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage.init(named: "banner")!, playlists: [Playlist]())
        for (key, value) in data {
            let image = UIImage.init(named: key)
            let name = value
            let playlist = Playlist.init(pic: image!, title: name, numberOfVideos: Int(arc4random_uniform(50)))
            user.playlists.append(playlist)
        }
        completion(user)
    }
    
    //MARK: Inits
    init(name: String, profilePic: UIImage, backgroundImage: UIImage, playlists: Array<Playlist>) {
        self.profilePic = profilePic
        self.backgroundImage = backgroundImage
        self.playlists = playlists
        self.name = name
    }
}

struct Playlist {
    
    let pic: UIImage
    let title: String
    let numberOfVideos: Int
    
    init(pic: UIImage, title: String, numberOfVideos: Int) {
        self.pic = pic
        self.title = title
        self.numberOfVideos = numberOfVideos
    }
}
