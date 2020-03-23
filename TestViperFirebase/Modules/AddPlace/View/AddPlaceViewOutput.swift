//
//  AddPlaceAddPlaceViewOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

protocol AddPlaceViewOutput {
   
   /**
    @author agadu
    Notify presenter that view is ready
    */
   
   func viewIsReady()
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String)
   
   func dismiss()
   
}
