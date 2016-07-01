//
//  Suggestions.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/1/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit
import Foundation

class Suggestions: UIView {
    
    
    let items  = [
        "hello there",
        "hello there how are you",
        "hello there meme",
        "hello there meaning",
        "hello there google",
        "hello there song",
        "hello there gif",
        "hello there lyrics",
        "hello there cheap trick",
        "hello there handsome"
    ]

    required    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

}
