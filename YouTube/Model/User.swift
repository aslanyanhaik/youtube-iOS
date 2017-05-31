//  MIT License

//  Copyright (c) 2017 Haik Aslanyan

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
