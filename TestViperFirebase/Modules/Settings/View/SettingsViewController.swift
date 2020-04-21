//
//  SettingsSettingsViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewInput {
   
   var output: SettingsViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
   }
   
   // MARK: SettingsViewInput
   func setupInitialState() {
      
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   
   
   
}
