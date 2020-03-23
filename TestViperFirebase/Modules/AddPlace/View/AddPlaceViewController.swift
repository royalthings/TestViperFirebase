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
   @IBOutlet weak var addButton: UIButton!
   
   var output: AddPlaceViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      addButton.layer.cornerRadius = 10
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
         title != "", discipline != "", latitude != "", longitude != "" else {
            showError(title: "Error", message: "Еnter correct data")
            return
      }
      output.addNewPlace(title: title, discipline: discipline, latitude: latitude, longitude: longitude)
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   } 
}
