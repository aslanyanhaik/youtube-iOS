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

class Video {
    
    //MARK: Properties
    let thumbnail: UIImage
    let title: String
    let views: Int
    let channel: Channel
    let duration: Int
    var videoLink: URL!
    let likes: Int
    let disLikes: Int
    var suggestedVideos = [SuggestedVideo]()
    
    //MARK: Inits
    init(title: String, channelName: String) {
        self.thumbnail = UIImage.init(named: title)!
        self.title = title
        self.views = Int(arc4random_uniform(1000000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1000))
        self.disLikes = Int(arc4random_uniform(1000))
        self.channel = Channel.init(name: channelName, image: UIImage.init(named: channelName)!)
    }
    
    //MARK: Methods
    class func fetchVideos(completion: @escaping (([Video]) -> Void)) {
        let video1 = Video.init(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let video2 = Video.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let video3 = Video.init(title: "What Bill Gates is afraid of", channelName: "Vox")
        let video4 = Video.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let video5 = Video.init(title: "A New History for Humanity – The Human Era", channelName: "Kurzgesagt – In a Nutshell")
        let video6 = Video.init(title: "Neural Network that Changes Everything - Computerphile", channelName: "Computerphile")
        let video7 = Video.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let video8 = Video.init(title: "Scott Galloway: The Retailer Growing Faster Than Amazon", channelName: "L2inc")
        var items = [video1, video2, video3, video4, video5, video6, video7, video8]
        items.shuffle()
        completion(items)
    }
    
    class func fetchVideo(completion: @escaping ((Video) -> Void)) {
        let video = Video.init(title: "Big Buck Bunny", channelName: "Blender Foundation")
        video.videoLink = URL.init(string: "http://sample-videos.com/video/mp4/360/big_buck_bunny_360p_10mb.mp4")!
        let suggestedVideo1 = SuggestedVideo.init(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let suggestedVideo2 = SuggestedVideo.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let suggestedVideo3 = SuggestedVideo.init(title: "What Bill Gates is afraid of", channelName: "Vox")
        let suggestedVideo4 = SuggestedVideo.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let suggestedVideo5 = SuggestedVideo.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let items = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
        video.suggestedVideos = items
        completion(video)
    }
}

struct SuggestedVideo {
    
    let title: String
    let channelName: String
    let thumbnail: UIImage
    
    init(title: String, channelName:String) {
        self.title = title
        self.channelName = channelName
        self.thumbnail = UIImage.init(named: title)!
    }
}

class Channel {
    
    let name: String
    let image: UIImage
    var subscribers = 0
    
    class func fetchData(completion: @escaping (([Channel]) -> Void)) {
        var items = [Channel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage.init(named: "channel\(i)")
            let channel = Channel.init(name: name, image: image!)
            items.append(channel)
        }
        items.shuffle()
        completion(items)
    }

    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
