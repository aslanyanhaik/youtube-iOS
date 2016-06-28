//
//  extension.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/24/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit


extension UIColor{
    
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
        return color
    }
}
