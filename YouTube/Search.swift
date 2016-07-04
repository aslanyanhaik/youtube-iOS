//
//  Search.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/4/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

protocol hideSearch {
    func hideSearchView(status : Bool)

}

import UIKit

class Search: UIView {
    
    //MARK: Properties
    
    lazy var searchView: UIView = {
       let sv = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 68))
        sv.backgroundColor = UIColor.white()
        sv.alpha = 0
        return sv
    }()
    lazy var backgroundView: UIView = {
        let bv = UIView.init(frame: self.frame)
        bv.backgroundColor = UIColor.black()
        bv.alpha = 0
        return bv
    }()
    
    lazy var backButton: UIButton = {
       let bb = UIButton.init(frame: CGRect.init(x: 0, y: 20, width: 48, height: 48))
        bb.setBackgroundImage(UIImage.init(named: "cancel"), for: [])
        bb.addTarget(self, action: #selector(Search.dismiss), for: .touchUpInside)
        return bb
    }()
    
    lazy var searchField: UITextField = {
        let sf = UITextField.init(frame: CGRect.init(x: 48, y: 20, width: self.frame.width - 50, height: 48))
        sf.placeholder = "Seach on Youtube"
        sf.keyboardAppearance = .dark
        return sf
    }()
    
    var delegate:hideSearch?
    
    //MARK: Methods
    
    func animate()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0.5
            self.searchView.alpha = 1
            self.searchField.becomeFirstResponder()
        })
    }
    
    
    func  dismiss()  {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.searchView.alpha = 0
            self.searchField.resignFirstResponder()
            }, completion: {(Bool) in
                self.delegate?.hideSearchView(status: true)
        })
    }
    //MARK: Inits
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backgroundView)
        self.addSubview(self.searchView)
        self.searchView.addSubview(self.searchField)
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(Search.dismiss)))
        self.searchView.addSubview(self.backButton)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
