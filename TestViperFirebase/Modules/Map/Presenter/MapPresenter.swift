//
//  MapMapPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

class MapPresenter: MapModuleInput, MapViewOutput, MapInteractorOutput {

   weak var view: MapViewInput!
   var interactor: MapInteractorInput!
   var router: MapRouterInput!
   
   func viewIsReady() {
      interactor.getPlaces()
   }
   
   func saveSelectedPlaceModel(_ placeModel: Place) {
      view.displayPlaceOnMap(placeModel)
   }
   
   func getRandomPlace() {
      interactor.getRandomPlace()
   }
   
   func displayRandomPlace(_ places: [Place]) {
      guard let randomPlace = places.randomElement() else { return }
      view.displayRandomPlace(randomPlace)
   }
   
   func savePlaces(_ places: [Place]) {
      view.savePlaces(places)
   }
   
   func addNewPlace() {
      router.goToAddNewPlaceScreen()
   }
   
   func prepare(_ segue: UIStoryboardSegue) {
      router.prepare(segue)
   }
   
   func featchAllPlaces() {
      interactor.getPlaces()
   }

}
