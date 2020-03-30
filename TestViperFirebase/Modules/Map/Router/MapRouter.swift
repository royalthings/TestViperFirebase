//
//  MapMapRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

class MapRouter: MapRouterInput {

   weak var viewController: MapViewController!
   
   func goToAddNewPlaceScreen() {
      viewController.performSegue(withIdentifier: "addPlaceFromMap", sender: nil)
   }
   
   func prepare(_ segue: UIStoryboardSegue) {
      if segue.identifier == "addPlaceFromMap" {
         passDataToAddNewPlace(segue)
      }
   }
   
   func passDataToAddNewPlace(_ segue: UIStoryboardSegue) {
      
      let showAddPlaceViewController = segue.destination as! AddPlaceViewController
      
      guard let newCoordinate = viewController.newCoordinate else {
         //TODO: - 
         return
      }
      let latitude = String(newCoordinate.latitude)
      let longitude = String(newCoordinate.longitude)
      showAddPlaceViewController.output.addNewCoordinate(latitude: latitude, longitude: longitude)
   }
   
   func goToDetailScreen() {
      let configurator = DetailModuleConfigurator()
      let (moduleView, _) = configurator.moduleViewAndInput()
      
      viewController.present(moduleView, animated: true, completion: nil)
   }
}
