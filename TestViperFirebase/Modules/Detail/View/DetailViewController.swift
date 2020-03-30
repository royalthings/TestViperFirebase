//
//  DetailDetailViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 30/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailViewInput {
   
   var output: DetailViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
   }
   
   
   // MARK: DetailViewInput
   func setupInitialState() {
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
}
