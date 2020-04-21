//
//  MainMainViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewInput {
   
   //MARK: - Outlets
   @IBOutlet weak var placesTableView: UITableView!
   @IBOutlet weak var footerLabel: UILabel!
   
   var places: [Place] = []
   var deletePlaceIndexPath: IndexPath? = nil
   
   var output: MainViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
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
      showFooterText()
      placesTableView.reloadData()
   }
   
   fileprivate func showFooterText() {
      if places.count == 0 {
         self.footerLabel.text = "Click plus to add a new place."
      } else {
         self.footerLabel.text = "Swipe a cell with a place to mark it as visited or delete. Click plus to add a new place."
      }
   }
   
   // MARK: MainViewInput
   func setupInitialState() {
      output.featchAllPlaces()
   }
   
   func showError(title: String, message: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      present(alertController, animated: true, completion: nil)
   }
   
   fileprivate func confirmDelete() {
      let alertController = UIAlertController(title: "Delete place", message: "Are you sure you want to delete place?", preferredStyle: .actionSheet)
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePlanet)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(deleteAction)
      alertController.addAction(cancelAction)
      present(alertController, animated: true, completion: nil)
   }
   
   fileprivate func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
      if let indexPath = deletePlaceIndexPath {
         if let placeId = places[indexPath.row].placeId {
            output.deletePlace(placeId)
         }
      }
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      output.passDataToMap(segue)
   }
   
   //MARK: Actions
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }

   @IBAction func addPlaceAction(_ sender: Any) {
      output.addNewPlace()
   }
}

//MARK: - UITableViewDataSource
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
      guard let discipline = places[index].discipline else { return UITableViewCell() }
      cell.nameLabel.text = places[index].title
      cell.deskriptionLabel.text = places[index].discipline
      cell.selectPlaceImage(discipline: discipline)
      return cell
   }
}

//MARK: - UITableViewDelegate
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

   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      guard let placeId = places[indexPath.row].placeId else { return nil }
      deletePlaceIndexPath = indexPath
      let placeIsVisit = places[indexPath.row].isVisit
      let deleteTitle = "Delete"
      let selectTitle = "Select as visited"

      guard places.count > 0 else {
         return nil
      }

      let deleteAction = UIContextualAction(style: .normal, title: deleteTitle) { (action, view, completion) in
         self.confirmDelete()
         completion(true)
      }

      let isVisitAction = UIContextualAction(style: .normal, title: selectTitle) { (action, view, completion) in
         if placeIsVisit == false {
            self.output.selectPlaceAsVisit(placeId)
            completion(true)
         } else {
            self.output.deselectPlaceAsVisit(placeId)
            completion(true)
         }
      }

      deleteAction.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
      isVisitAction.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)

      if placeIsVisit == false {
         isVisitAction.title = selectTitle
      } else {
         isVisitAction.image = #imageLiteral(resourceName: "check")
      }

      return UISwipeActionsConfiguration(actions: [deleteAction, isVisitAction])
   }
}
