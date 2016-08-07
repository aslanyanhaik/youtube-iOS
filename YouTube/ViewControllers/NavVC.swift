//
//  NavVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 8/4/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

class NavVC: UINavigationController, PlayerVCDelegate  {

    //MARK: Properties
    lazy var playVC: PlayVC = {
        let pvc: PlayVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayVC") as! PlayVC
        self.addChildViewController(pvc)
        pvc.view.frame = CGRect.init(origin: self.hiddenOrigin, size: UIScreen.main().bounds.size)
        pvc.didMove(toParentViewController: self)
        pvc.delegate = self
        return pvc
    }()
    let statusView: UIView = {
        let st = UIView.init(frame: UIApplication.shared().statusBarFrame)
        st.backgroundColor = UIColor.black()
        st.alpha = 0.15
        return st
    }()
    let hiddenOrigin: CGPoint = {
        let y = UIScreen.main().bounds.height - (UIScreen.main().bounds.width * 9 / 32) - 10
        let x = -UIScreen.main().bounds.width
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main().bounds.width/2 - 10
        let y = UIScreen.main().bounds.height - (UIScreen.main().bounds.width * 9 / 32) - 10
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)

    //Methods
    func customization()  {
        self.view.addSubview(self.statusView)
        self.view.addSubview(self.playVC.view)
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        self.addChildViewController(mainVC)
        mainVC.didMove(toParentViewController: self)
    }
    
    func animatePlayView(toState: stateOfVC) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                self.playVC.view.frame.origin = self.fullScreenOrigin
                })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.playVC.view.frame.origin = self.minimizedOrigin
            })
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                self.playVC.view.frame.origin = self.hiddenOrigin
            })
        }
    }
    ///////////////
    func positionDuringSwipe(scaleFactor: CGFloat, state: stateOfVC) -> CGPoint {
        let absolutScaleFactor = CGFloat.abs(scaleFactor)
        let width = UIScreen.main().bounds.width * absolutScaleFactor * 0.005
        let height = width * 9 / 16
        let x = ((UIScreen.main().bounds.width - 10) * absolutScaleFactor / 100) - width
        let y = ((UIScreen.main().bounds.height - 10) * absolutScaleFactor / 100) - height
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }
    
    //MARK: Delegate methods
    func didMinimize() {
        self.animatePlayView(toState: .minimized)
    }
    
    func didmaximize(){
        self.animatePlayView(toState: .fullScreen)
    }
    
    func didEndedSwipe(toState: stateOfVC){
        self.animatePlayView(toState: toState)
    }
    
    func swipeToMinimize(translation: CGFloat, fromState: stateOfVC, toState: stateOfVC){
        switch toState {
        case .fullScreen:
            print("needs to be implemented")
        case .hidden:
            self.playVC.view.frame.origin.x = translation
        default:
            break
        }
    }
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
}
