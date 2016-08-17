//
//  PlayVC.swift
//  YouTube
//
//  Created by Haik Aslanyan on 7/25/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//
protocol PlayerVCDelegate {
    func didMinimize()
    func didmaximize()
    func swipeToMinimize(translation: CGFloat, toState: stateOfVC)
    func didEndedSwipe(toState: stateOfVC)
}

import UIKit
import AVFoundation
class PlayVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var minimizeButton: UIButton!
    let link: URL = globalVariables.videoLink
    var video: Video?
    var delegate: PlayerVCDelegate?
    var state = stateOfVC.hidden
    var direction = Direction.none
    var videoPlayer = AVPlayer.init()
    
    //MARK: Methods
    func customization() {
        self.view.backgroundColor = UIColor.clear
        self.player.layer.anchorPoint.applying(CGAffineTransform.init(translationX: -0.5, y: -0.5))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.player.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(PlayVC.tapPlayView)))
        NotificationCenter.default.addObserver(self, selector: #selector(PlayVC.tapPlayView), name: NSNotification.Name("open"), object: nil)
    }

    func animate()  {
        switch self.state {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, animations: {
                self.minimizeButton.alpha = 1
                self.tableView.alpha = 1
                self.player.transform = CGAffineTransform.identity
                UIApplication.shared.isStatusBarHidden = true
            })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                UIApplication.shared.isStatusBarHidden = false
                self.minimizeButton.alpha = 0
                self.tableView.alpha = 0
                let scale = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                let trasform = scale.concatenating(CGAffineTransform.init(translationX: -self.player.bounds.width/4, y: -self.player.bounds.height/4))
                self.player.transform = trasform
            })
        default: break
        }
    }
    
    func changeValues(scaleFactor: CGFloat) {
        self.minimizeButton.alpha = 1 - scaleFactor
        self.tableView.alpha = 1 - scaleFactor
        let scale = CGAffineTransform.init(scaleX: (1 - 0.5 * scaleFactor), y: (1 - 0.5 * scaleFactor))
        let trasform = scale.concatenating(CGAffineTransform.init(translationX: -(self.player.bounds.width / 4 * scaleFactor), y: -(self.player.bounds.height / 4 * scaleFactor)))
        self.player.transform = trasform
    }
    
    func tapPlayView()  {
        self.videoPlayer.play()
        self.state = .fullScreen
        self.delegate?.didmaximize()
        self.animate()
    }
    
    @IBAction func minimize(_ sender: UIButton) {
        self.state = .minimized
        self.delegate?.didMinimize()
        self.animate()
    }
    
    @IBAction func minimizeGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let velocity = sender.velocity(in: nil)
            if abs(velocity.x) < abs(velocity.y) {
                self.direction = .up
            } else {
                self.direction = .left
            }
        }
        var finalState = stateOfVC.fullScreen
        switch self.state {
        case .fullScreen:
            let factor = (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
            self.changeValues(scaleFactor: factor)
            self.delegate?.swipeToMinimize(translation: factor, toState: .minimized)
            finalState = .minimized
        case .minimized:
                if self.direction == .left {
                finalState = .hidden
                let factor: CGFloat = sender.translation(in: nil).x
                self.delegate?.swipeToMinimize(translation: factor, toState: .hidden)
            } else {
                finalState = .fullScreen
                let factor = 1 - (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
                self.changeValues(scaleFactor: factor)
                self.delegate?.swipeToMinimize(translation: factor, toState: .fullScreen)
            }
        default: break
        }
        if sender.state == .ended {
            self.state = finalState
            self.animate()
            self.delegate?.didEndedSwipe(toState: self.state)
            if self.state == .hidden {
                self.videoPlayer.pause()
            }
        }
    }
    
    //MARK: Delegate & dataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.video?.suggestedVideos.count {
            return count + 1
        } else {
            return 0
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! headerCell
            cell.title.text = self.video!.title
            cell.viewCount.text = "\(self.video!.viewCount) views"
            cell.likes.text = String(self.video!.likes)
            cell.disLikes.text = String(self.video!.disLikes)
            cell.channelTitle.text = self.video!.channelTitle
            cell.channelPic.image = self.video!.channelPic
            cell.channelPic.layer.cornerRadius = 25
            cell.channelPic.clipsToBounds = true
            cell.channelSubscribers.text = "\(self.video!.channelSubscribers) subscribers"
            cell.selectionStyle = .none
            returnCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! videoCell
            cell.name.text = self.video?.suggestedVideos[indexPath.row - 1].name
            cell.title.text = self.video?.suggestedVideos[indexPath.row - 1].title
            cell.tumbnail.image = self.video?.suggestedVideos[indexPath.row - 1].thumbnail
            returnCell = cell
        }
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch indexPath.row {
        case 0:
            height = 180
        default:
            height = 90
        }
        return height
    }
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
        Video.download(link: self.link) { (video) in
            self.video = video
            DispatchQueue.main.async(execute: {
                self.videoPlayer = AVPlayer.init(url: video.videoLink)
                let playerLayer = AVPlayerLayer.init(player: self.videoPlayer)
                playerLayer.frame =  self.player.bounds
                self.player.layer.addSublayer(playerLayer)
                if self.state != .hidden {
                    self.videoPlayer.play()
                }
                self.tableView.reloadData()
            })
        }
    }
 }

class headerCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var disLikes: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var channelSubscribers: UILabel!
    
    //MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class videoCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var tumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    
    //MARK: Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
