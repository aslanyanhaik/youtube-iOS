//
//  NavViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/24/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    //MARK: - Customization
    
    func customization()  {
        
        // StatusBar customization
        
        let statusBarBackgroundView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main().bounds.size.width, height: 20))
        statusBarBackgroundView.backgroundColor = UIColor.rbg(r: 195, g: 28, b: 20)
        self.view.addSubview(statusBarBackgroundView)
       
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
