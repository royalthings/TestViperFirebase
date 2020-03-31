//
//  MainMainPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {

   weak var view: MainViewInput!
   var interactor: MainInteractorInput!
   var router: MainRouterInput!
   
   func viewIsReady() {
      
   }
   
   func displayAllPlaces(_ places: [Place]) {
      view.displayPlaces(places)
   }
   
   func featchAllPlaces() {
      interactor.featchAllPlaces()
   }
   
   func goToMapScreen() {
      router.goToMapScreen()
   }
   
   func passDataToMap(_ segue: UIStoryboardSegue) {
      router.passDataToMap(segue)
   }
   
   func addNewPlace() {
      router.goToAddNewPlaceScreen()
   }
   
   func dismiss() {
      router.dismiss()
   }
   
   func deletePlace(_ placeId: String) {
      interactor.deletePlace(placeId)
   }

   func isDelete(_ isDelete: Bool) {
      if isDelete {
         view.setupInitialState()
      }
   }
   
   func selectPlaceAsVisit(_ placeId: String) {
      interactor.selectPlaceAsVisit(placeId)
   }
   
   func isSelect(_ isSelect: Bool) {
      if isSelect {
         view.setupInitialState()
      }
   }
   
   func deselectPlaceAsVisit(_ placeId: String) {
      interactor.deselectPlaceAsVisit(placeId)
   }
   
   func isDeselect(_ isDeselect: Bool) {
      if isDeselect {
         view.setupInitialState()
      }
   }
}
