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
      dataManager.getPlaces { [weak self] (places) in
         self?.output.displayAllPlaces(places)
      }
   }
   
   func deletePlace(_ placeId: String) {
      dataManager.delete(withId: placeId) { (isDelete) in
         self.output.isDelete(isDelete)
      }
   }
}
