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
    
    let searchView: UIView = {
       let sv = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main().bounds.width, height: 68))
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
    
    var delegate:hideSearch?
    
    //MARK: Methods
    
    func animate()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0.5
            self.searchView.alpha = 1
        })
    }
    
    
    func  dismiss()  {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.searchView.alpha = 0
            }, completion: {(Bool) in
                self.delegate?.hideSearchView(status: true)
        })
    }
    //MARK: Inits
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backgroundView)
        self.addSubview(self.searchView)
    self.backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(Search.dismiss)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
