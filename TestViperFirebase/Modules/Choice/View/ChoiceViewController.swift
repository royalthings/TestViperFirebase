//
//  ChoiceChoiceViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChoiceViewController: UIViewController, ChoiceViewInput {

   //MARK: - Outlets
   @IBOutlet weak var showListOfPlacesButton: UIButton!
   @IBOutlet weak var showMapButton: UIButton!
   @IBOutlet weak var helloLabel: UILabel!
   
   var output: ChoiceViewOutput!
   
   let email = Auth.auth().currentUser?.email
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      showListOfPlacesButton.layer.cornerRadius = 10
      showMapButton.layer.cornerRadius = 10
      
      obtainUserName()
   }
   
   
   // MARK: ChoiceViewInput
   func setupInitialState() {
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   func obtainUserName() {
      output.obtainUserName(email: email)
   }
   
   func saveName(userName: String) {
      helloLabel.text = "Hello, " + userName + "!"
   }
   
   
   //MARK: - Actions
   @IBAction func loguotAction(_ sender: Any) {
      output.signOut()
   }
   
   
   @IBAction func showListOfPlacesAction(_ sender: Any) {
      output.goToMainScreen()
   }
   
   
   @IBAction func showMapAction(_ sender: Any) {
      output.goToMapScreen()
   }
   
   
}
