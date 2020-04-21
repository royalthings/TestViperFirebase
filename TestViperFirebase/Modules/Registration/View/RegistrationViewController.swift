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
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var confirmPasswordTextfield: UITextField!
   @IBOutlet weak var cityTextField: UITextField!
   @IBOutlet weak var signupButton: UIButton!
   
   @IBOutlet weak var dropDownMenu: UIPickerView!
   
   var output: RegistrationViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      signupButton.layer.cornerRadius = 10
      dropDownMenu.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
      nameTextField.text = ""
      passwordTextField.text = ""
      confirmPasswordTextfield.text = ""
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   @IBAction func signupAction(_ sender: Any) {
      view.endEditing(true)
      
      guard let email = emailTextField.text, let name = nameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextfield.text, let city = cityTextField.text, email != "", name != "", password != "", confirmPassword != "", city != "" else {
         showError(title: "Error", message: "Enter correct data")
         return
      }
      
      let filteredEmail = String.filteredCharacters(enteredText: email)
      let filteredName = String.filteredCharacters(enteredText: name)
      let filteredPassword = String.filteredCharacters(enteredText: password)
      let filteredConfirmPassword = String.filteredCharacters(enteredText: confirmPassword)
      
      if email == filteredEmail, name == filteredName, password == filteredPassword, confirmPassword == filteredConfirmPassword {
         if password == confirmPassword {
            let finalHash = User.passwordHash(from: email, password: password)
            output.userRegistration(email: email, name: name, password: finalHash, city: city)
         } else {
            showError(title: "Error", message: "Enter correct password")
         }
      } else {
         showError(title: "Error", message: "You have entered the wrong characters.")
      }
   }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return Constants.cityListMenu.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      view.endEditing(true)
      return Constants.cityListMenu[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      cityTextField.text = Constants.cityListMenu[row]
      dropDownMenu.isHidden = true
   }
}

extension RegistrationViewController: UITextFieldDelegate {
   func textFieldDidBeginEditing(_ textField: UITextField) {
      if textField == cityTextField {
         dropDownMenu.isHidden = false
         cityTextField.endEditing(true)
      }
   }
}
