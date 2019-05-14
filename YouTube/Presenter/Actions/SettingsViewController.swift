//
//  SettingsViewController.swift
//  YouTube
//
//  Created by Haik Aslanyan on 5/14/19.
//  Copyright © 2019 Haik Aslanyan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
 
 class SettingsView: UIView, UITableViewDelegate, UITableViewDataSource {
 
 //MARK: Properties
 @IBOutlet weak var tableView: UITableView!
 @IBOutlet weak var backgroundView: UIButton!
 @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
 let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Switch Account", "Cancel"]
 
 //MARK: Methods
 func customization() {
 self.tableView.delegate = self
 self.tableView.dataSource = self
 self.backgroundView.alpha = 0
 self.tableViewBottomConstraint.constant = -self.tableView.bounds.height
 self.layoutIfNeeded()
 }
 
 @IBAction func hideSettingsView(_ sender: Any) {
 self.tableViewBottomConstraint.constant = -self.tableView.bounds.height
 UIView.animate(withDuration: 0.3, animations: {
 self.backgroundView.alpha = 0
 self.layoutIfNeeded()
 }) { _ in
 self.isHidden = true
 }
 }
 
 //MARK: Delegates
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return self.items.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
 cell.textLabel?.text = self.items[indexPath.row]
 cell.imageView?.image = UIImage.init(named: self.items[indexPath.row])
 return cell
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 self.hideSettingsView(self)
 }
 
 //MARK: View LifeCycle
 override func awakeFromNib() {
 super.awakeFromNib()
 self.customization()
 }
 }

 */
