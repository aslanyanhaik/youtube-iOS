//
//  ObjectPlaceHolder.swift
//  YouTube
//
//  Created by Haik Aslanyan on 1/14/20.
//  Copyright © 2020 Haik Aslanyan. All rights reserved.
//

import Foundation

struct ObjectPlaceholder {
  
  let titleText: String
  let descriptionText: String
  let imageName: String
  let shouldShowSignInButton: Bool
  
}

extension ObjectPlaceholder {
  
  static var inbox: ObjectPlaceholder {
    ObjectPlaceholder(titleText: "Your notifications live here", descriptionText: "Subscrible to your favorite channels to get notified about their latest videos.", imageName: "bell.fill", shouldShowSignInButton: false)
  }
  
  static var library: ObjectPlaceholder {
    ObjectPlaceholder(titleText: "Enjoy your favorite videos", descriptionText: "Sign in to acess videos that you've liked or saved", imageName: "folder.fill", shouldShowSignInButton: true)
  }
  
  static var subscription: ObjectPlaceholder {
    ObjectPlaceholder(titleText: "Don't miss new videos", descriptionText: "Sign in to see updates from your favorite YouTube channels", imageName: "rectangle.stack.fill", shouldShowSignInButton: true)
  }
  
}
