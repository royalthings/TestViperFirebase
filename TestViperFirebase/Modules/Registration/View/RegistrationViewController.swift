//
//  RegistrationRegistrationViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationViewInput {

   @IBOutlet weak var emailTextField: UITextField!
   
   @IBOutlet weak var passwordTextField: UITextField!
   
   @IBOutlet weak var confirmPasswordTextfield: UITextField!
   
   @IBOutlet weak var signupButton: UIButton!
   
   var output: RegistrationViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      signupButton.layer.cornerRadius = 10
   }
   
   
   // MARK: RegistrationViewInput
   func setupInitialState() {
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   func cleanTextFields() {
      emailTextField.text = ""
      passwordTextField.text = ""
      confirmPasswordTextfield.text = ""
   }
   
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   @IBAction func signupAction(_ sender: Any) {
      
      guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextfield.text, email != "", password != "", confirmPassword != "" else {
         showError(title: "Error", message: "Enter correct data")
         return
      }
      if password == confirmPassword {
         output.userRegistration(email: email, password: password)
      } else {
         showError(title: "Error", message: "Enter correct password")
      }
   }
   
   
   
}
