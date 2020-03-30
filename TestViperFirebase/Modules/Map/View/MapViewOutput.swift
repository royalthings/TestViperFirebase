//
//  MapMapViewOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

protocol MapViewOutput {
   
   /**
    @author agadu
    Notify presenter that view is ready
    */
   
   func viewIsReady()
   
   func saveSelectedPlaceModel(_ placeModel: Place)
   
   func getRandomPlace()
   
   func addNewPlace()
   
   func prepare(_ segue: UIStoryboardSegue)
   
   func featchAllPlaces()
}
