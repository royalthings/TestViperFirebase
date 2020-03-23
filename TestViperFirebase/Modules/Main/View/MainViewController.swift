//
//  MainMainViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController, MainViewInput {
 
   @IBOutlet weak var placesTableView: UITableView!
   
   @IBOutlet weak var nameLabel: UILabel!
   
   var places: [Place] = []

   var output: MainViewOutput!

   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
   }
   
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       placesTableView.reloadData()
       setupInitialState()
   }
   
   func displayPlaces(_ places: [Place]) {
      self.places = []
      for element in places {
         self.places.append(element)
         DispatchQueue.main.async {
            self.placesTableView.reloadData()
         }
      }
   }

   // MARK: MainViewInput
   func setupInitialState() {
      output.featchAllPlaces()
      nameLabel.text = Auth.auth().currentUser?.email
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      output.passDataToMap(segue)
   }
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   
   @IBAction func addPlaceAction(_ sender: Any) {
      output.addNewPlace()
   }
}

extension MainViewController: UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return places.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = placesTableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
      
      let index = indexPath.row
      cell.nameLabel.text = places[index].title
      cell.deskriptionLabel.text = places[index].discipline
      return cell
   }
}

extension MainViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      output.goToMapScreen()
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         guard let placeId = places[indexPath.row].placeId else { return }
         output.deletePlace(placeId)
      }
   }
}