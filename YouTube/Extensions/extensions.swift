//
//  extension.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/24/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


// uicolor init simplified
extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

// UIImage with downloadable content
extension UIImage {
  class  func contentOfURL(link: String) -> UIImage {
    let url = URL.init(string: link)!
    var image = UIImage()
    do{
        let data = try Data.init(contentsOf: url)
        image = UIImage.init(data: data)!
    } catch _ {
        print("error downloading images")
    }
    return image
    }
}


enum stateOfVC {
    case minimized
    case fullScreen
    case hidden
}
enum Direction {
    case up
    case left
    case none
}

