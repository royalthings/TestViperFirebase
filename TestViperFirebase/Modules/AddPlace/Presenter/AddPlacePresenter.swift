//
//  AddPlaceAddPlacePresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

class AddPlacePresenter: AddPlaceModuleInput, AddPlaceViewOutput, AddPlaceInteractorOutput {

   weak var view: AddPlaceViewInput!
   var interactor: AddPlaceInteractorInput!
   var router: AddPlaceRouterInput!
   
   func viewIsReady() {
      
   }
   
   func dismiss() {
      router.dismiss()
   }
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, city: String) {
      interactor.addNewPlace(title: title, discipline: discipline, latitude: latitude, longitude: longitude, city: city)
   }
   
   func passPlaceToShowMainSceene(_ isAdded: Bool) {
      if isAdded {
         router.dismiss()
      } else {
         view.showError(title: "Error", message: "Еnter correct data")
      }
   }
   
   func addNewCoordinate(latitude: String, longitude: String) {
      view.addNewCoordinate(latitude: latitude, longitude: longitude)
   }
}
