//
//  GlobalVariables.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/28/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import Foundation

    //MARK: Variables


struct globalVariables {
    
    static let urlLink = URL.init(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
    
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


