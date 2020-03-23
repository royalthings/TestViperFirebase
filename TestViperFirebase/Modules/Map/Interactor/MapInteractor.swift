//
//  MapMapInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class MapInteractor: MapInteractorInput {
   
   weak var output: MapInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func getRandomPlace() {
      dataManager.getPlaces { (places) in
         self.output.displayRandomPlace(places)
      }
   }
}
