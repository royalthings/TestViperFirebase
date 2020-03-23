//
//  RegistrationRegistrationViewInput.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

protocol RegistrationViewInput: class {
   
   /**
    @author agadu
    Setup initial state of the view
    */
   
   func setupInitialState()
   
   func showError(title: String, message: String)
   
   func cleanTextFields()
}
