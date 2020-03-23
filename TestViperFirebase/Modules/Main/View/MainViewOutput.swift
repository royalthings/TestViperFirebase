//
//  MainMainViewOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

protocol MainViewOutput {
   
   /**
    @author agadu
    Notify presenter that view is ready
    */
   
   func viewIsReady()
   
   func featchAllPlaces()
   
   func goToMapScreen()
   
   func passDataToMap(_ segue: UIStoryboardSegue)
   
   func addNewPlace()
   
   func deletePlace(_ placeId: String)
   
   func dismiss()
   
}
