//
//  SettingsSettingsViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController, SettingsViewInput {
   
   
   @IBOutlet weak var settingsTableView: UITableView!
   let email = Auth.auth().currentUser?.email
   var userName = ""
   var userCity = ""
   
   var output: SettingsViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      obtainUserData()
      
      settingsTableView.tableFooterView = UIView(frame: .zero)
   }
   
   // MARK: SettingsViewInput
   func setupInitialState() {
      
   }
   
   func obtainUserData() {
      output.obtainUserData(email: email)
   }
   
   func saveData(userName: String, userCity: String) {
      self.userName = userName
      self.userCity = userCity
      DispatchQueue.main.async {
         self.settingsTableView.reloadData()
      }
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
}

extension SettingsViewController: UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 2
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0 {
         return 1
      } else {
         return 1
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.section == 0 {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
         cell.nameLabel.text = userName
         cell.emailLabel.text = email
         return cell
      } else {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
         cell.cityLabel.text = userCity
         return cell
      }
   }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      if section == 0 {
         return 0
      } else {
         return 40
      }
   }
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let headerView = UIView()
      if section == 0 {
         headerView.backgroundColor = .clear
         return headerView
      } else {
         headerView.backgroundColor = #colorLiteral(red: 0.7138805651, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
         return headerView
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.section == 0 {
         return 100
      } else {
         return 50
      }
   }
}

extension SettingsViewController: UITableViewDelegate {
   
}
