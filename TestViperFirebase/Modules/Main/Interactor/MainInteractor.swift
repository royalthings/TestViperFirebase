//
//  MainMainInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class MainInteractor: MainInteractorInput {

   weak var output: MainInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func featchAllPlaces() {
      dataManager.getUserPlaces { [weak self] (places) in
         self?.output.displayAllPlaces(places)
      }
   }
   
   func deletePlace(_ placeId: String) {
      dataManager.delete(withId: placeId) { (isDelete) in
         self.output.isDelete(isDelete)
      }
   }
   
   func selectPlaceAsVisit(_ placeId: String) {
      dataManager.selectAsVisit(withId: placeId) { (isSelect) in
         self.output.isSelect(isSelect)
      }
   }
   
   func deselectPlaceAsVisit(_ placeId: String) {
      dataManager.deselectAsVisit(withId: placeId) { (isDeselect) in
         self.output.isDeselect(isDeselect)
      }
   }
}
