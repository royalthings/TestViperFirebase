//
//  MainMainRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

class MainRouter: MainRouterInput {

   weak var viewController: MainViewController!
   
   func goToMapScreen() {
      viewController.performSegue(withIdentifier: "showMap", sender: nil)
   }
   
   func passDataToMap(_ segue: UIStoryboardSegue) {
      if segue.identifier == "showMap" {
         passDataToShowMapSceene(segue)
      }
   }
   
   func passDataToShowMapSceene(_ segue: UIStoryboardSegue) {
      if let selectedIndexPath = viewController.placesTableView.indexPathsForSelectedRows?.first {
         let selectedPlaceModel = viewController.places[selectedIndexPath.row]
         let showMapViewController = segue.destination as! MapViewController
         showMapViewController.modalPresentationStyle = .fullScreen
         showMapViewController.output.saveSelectedPlaceModel(selectedPlaceModel)
      }
   }
   
   func goToAddNewPlaceScreen() {
      
      let configurator =  AddPlaceModuleConfigurator()
      let (moduleView, _) = configurator.moduleViewAndInput()
      
      viewController.present(moduleView, animated: true, completion: nil)
   }
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
}
