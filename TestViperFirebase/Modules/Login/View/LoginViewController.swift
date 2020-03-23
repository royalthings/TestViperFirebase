//
//  LoginLoginViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, LoginViewInput {
   
   struct Notifications {
      static let needUpdateUserName = NSNotification.Name(rawValue: "needUpdateUserName")
   }
   
   struct Keys {
      static let userNameKey = "userNameKey"
   }
   
   @IBOutlet weak var loginTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var loginButton: UIButton!
   
   var output: LoginViewOutput!
   
   var userName = ""
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      loginButton.layer.cornerRadius = 10
      loginTextField.text = "qwerty@qwerty.com"
      passwordTextField.text = "qwerty"
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      didUpdateUserName()
//      setUserName(userName)
   }
   
   // MARK: LoginViewInput
   func setupInitialState() {
      
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   private func didUpdateUserName(userName: Bool = false) {
      NotificationCenter.default.post(name: Notifications.needUpdateUserName, object: nil, userInfo: nil)
   }
   
   func setUserName(_ userName: String) {
      self.userName = userName
   }
   
   @IBAction func loginAction(_ sender: Any) {
      guard let email = loginTextField.text, let password = passwordTextField.text, email != "", password != "" else {
         showError(title: "Error", message: "Enter correct login or password")
         return
      }
      output.userIsLogin(email: email, password: password)
   }
   
   @IBAction func registrationAction(_ sender: Any) {
      output.registration()
   }
   
   
}
