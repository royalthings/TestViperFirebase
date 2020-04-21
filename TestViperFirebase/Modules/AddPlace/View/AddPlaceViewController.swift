//
//  AddPlaceAddPlaceViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController, AddPlaceViewInput {
   
   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var disciplineTextField: UITextField!
   @IBOutlet weak var latitudeTextField: UITextField!
   @IBOutlet weak var longitudeTextField: UITextField!
   @IBOutlet weak var cityTextField: UITextField!
   @IBOutlet weak var addButton: UIButton!
   
   @IBOutlet weak var placeDropDownMenu: UIPickerView!
   @IBOutlet weak var cityDropDownMenu: UIPickerView!
   
   var output: AddPlaceViewOutput!
   var latitude: String?
   var longitude: String?
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      addButton.layer.cornerRadius = 10
      placeDropDownMenu.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      cityDropDownMenu.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
      latitudeTextField.text = latitude
      longitudeTextField.text = longitude
   } 
   
   // MARK: AddPlaceViewInput
   func setupInitialState() {
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   @IBAction func addAction(_ sender: Any) {
      
      guard let title = nameTextField.text,
         let discipline = disciplineTextField.text,
         let latitude = latitudeTextField.text,
         let longitude = longitudeTextField.text,
         let city = cityTextField.text,
         title != "", discipline != "", latitude != "", longitude != "", city != "" else {
            showError(title: "Error", message: "Еnter correct data")
            return
      }
      
      if Double(latitude) == nil || Double(longitude) == nil {
         showError(title: "Error", message: "Еnter correct coordinate")
      }
      
      let filteredTitle = String.filteredCharacters(enteredText: title)
      let filteredLatitude = String.filteredCharacters(enteredText: latitude)
      let filteredLongitude = String.filteredCharacters(enteredText: longitude)
      
      if title == filteredTitle, latitude == filteredLatitude, longitude == filteredLongitude {
         output.addNewPlace(title: title, discipline: discipline, latitude: latitude, longitude: longitude, city: city)
      } else {
         showError(title: "Error", message: "You have entered the wrong characters.")
      }
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   func addNewCoordinate(latitude: String, longitude: String) {
      self.latitude = latitude
      self.longitude = longitude
   }
}

extension AddPlaceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      if pickerView == placeDropDownMenu {
         return Constants.placeListMenu.count
      } else {
         return Constants.cityListMenu.count
      }
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      view.endEditing(true)
      if pickerView == placeDropDownMenu {
         return Constants.placeListMenu[row]
      } else {
         return Constants.cityListMenu[row]
      }
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      if pickerView == placeDropDownMenu {
         disciplineTextField.text = Constants.placeListMenu[row]
         placeDropDownMenu.isHidden = true
      } else {
         cityTextField.text = Constants.cityListMenu[row]
         cityDropDownMenu.isHidden = true
      }
   }
}

extension AddPlaceViewController: UITextFieldDelegate {
   func textFieldDidBeginEditing(_ textField: UITextField) {
      if textField == disciplineTextField {
         placeDropDownMenu.isHidden = false
         disciplineTextField.endEditing(true)
      } else if textField == cityTextField {
         cityDropDownMenu.isHidden = false
         cityTextField.endEditing(true)
      }
   }
}
