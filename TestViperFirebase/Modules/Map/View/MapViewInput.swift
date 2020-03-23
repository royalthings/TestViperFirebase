//
//  MapMapViewInput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import MapKit

protocol MapViewInput: class {
   
   /**
    @author agadu
    Setup initial state of the view
    */
   
   func setupInitialState()
   
   func displayPlaceOnMap(_ placeModel: Place)
   
   func centerMapOnLocation(location: CLLocation)
   
   func displayRandomPlace(_ place: Place)
}
