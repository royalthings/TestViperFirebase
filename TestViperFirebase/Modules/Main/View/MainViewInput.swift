//
//  MainMainViewInput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

protocol MainViewInput: class {
   
   /**
    @author agadu
    Setup initial state of the view
    */
   
   func setupInitialState()
   
   func displayPlaces(_ places: [Place])
   
   func showError(title: String, message: String)
}
