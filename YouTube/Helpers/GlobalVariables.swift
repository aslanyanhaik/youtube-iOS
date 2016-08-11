//
//  GlobalVariables.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/28/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import Foundation
import UIKit

    //MARK: Variables


struct globalVariables {
    static let urlLink = URL.init(string: "http://mexonis.com/home.json")!
    static let moreURLLink = URL.init(string: "http://mexonis.com/more.json")!
    static let subscriptionsLink = URL.init(string: "http://mexonis.com/subscriptions.json")!
    static let profileLink = URL.init(string: "http://mexonis.com/profile.json")!
    static let videoLink = URL.init(string: "http://mexonis.com/video.json")!
    static let rect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
    static let width  = UIScreen.main.bounds.width
    static let height: CGFloat =  64
}

    //MARK: Global Functions
func secondsToHoursMinutesSeconds (seconds : Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let second = (seconds % 3600) % 60
    let hoursString: String = {
         let hs = String(hours)
        return hs
    }()
    
    let minutesString: String = {
        var ms = ""
        if  (minutes <= 9 && minutes >= 0) {
        ms = "0\(minutes)"
        } else{
        ms = String(minutes)
        }
        return ms
    }()
    
    let secondsString: String = {
        var ss = ""
        if  (second <= 9 && second >= 0) {
            ss = "0\(second)"
        } else{
            ss = String(second)
        }
        return ss
    }()
    
    var label = ""
    if hours == 0 {
        label =  minutesString + ":" + secondsString
    } else{
        label = hoursString + ":" + minutesString + ":" + secondsString
    }
    return label
}

func requestSuggestionsURL(text: String) -> URL {
    let netText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet())!
    let url = URL.init(string: "https://api.bing.com/osjson.aspx?query=\(netText)")!
    return url
}

func showNotification() {
    print("Please check your internet connection")
}



