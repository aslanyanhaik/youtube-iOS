//
//  UIViewExtension.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

extension UIView {
  
  func pinEdgesToSuperView(insets: UIEdgeInsets) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    let _ = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: insets.top).isActive = true
    let _ = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: insets.bottom).isActive = true
    let _ = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1.0, constant: insets.left).isActive = true
    let _ = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1.0, constant: insets.right).isActive = true
  }
}
