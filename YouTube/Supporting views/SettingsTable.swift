//
//  TableView.swift
//  YouTube
//
//  Created by Haik Aslanyan on 6/30/16.
//  Copyright © 2016 Haik Aslanyan. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func hideSettingsView(status : Bool)
}

class Settings: UIView,  UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Switch Account", "Cancel"]
    let imageNames = ["settings", "termsPrivacyPolicy", "sendFeedback", "help", "swithAccount", "cancel"]
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.init(x: 0, y: self.bounds.height, width: self.bounds.width, height: 288))
        tb.isScrollEnabled = false
        return tb
    }()
    
    lazy var backgroundView: UIView = {
       let bv = UIView.init(frame: self.frame)
       bv.backgroundColor = UIColor.black
        bv.alpha = 0
        return bv
    }()
    
    var delegate: SettingsDelegate?
    
    //MARK: Methods
    func animate()  {
        UIView.animate(withDuration: 0.3, animations: {
        self.tableView.frame.origin.y -= 288
        self.backgroundView.alpha = 0.5
        })
    }
    
    func  dismiss()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.tableView.frame.origin.y += 288
            }, completion: {(Bool) in
                self.delegate?.hideSettingsView(status: true)
        })
    }
    
    //MARK: TableView Delegate, DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.imageView?.image = UIImage.init(named: imageNames[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss()
    }
  
    //Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(Settings.dismiss)))
        self.addSubview(self.backgroundView)
        self.addSubview(tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.separatorStyle = .none
    }
    
}



