//
//  AddPlaceAddPlaceViewInput.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

protocol AddPlaceViewInput: class {
   
   /**
    @author agadu
    Setup initial state of the view
    */
   
   func setupInitialState()

   func showError(title: String, message: String)
}
