//
//  ChoiceChoiceViewInput.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

protocol ChoiceViewInput: class {
   
   /**
    @author agadu
    Setup initial state of the view
    */
   
   func setupInitialState()
   
   func showError(title: String, message: String)
   
   func obtainUserName()
   
   func saveName(userName: String)
}
