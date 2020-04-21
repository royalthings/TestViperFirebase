//
//  AddPlaceAddPlaceInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class AddPlaceInteractor: AddPlaceInteractorInput {
   
   weak var output: AddPlaceInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, city: String) {
      dataManager.addNewPlace(title: title, discipline: discipline, latitude: latitude, longitude: longitude, city: city) { (isAdded) in
         self.output.passPlaceToShowMainSceene(isAdded)
      }
   }
   
}
