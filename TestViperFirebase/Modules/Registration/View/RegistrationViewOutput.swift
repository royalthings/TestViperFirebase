//
//  RegistrationRegistrationViewOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

protocol RegistrationViewOutput {
   
   /**
    @author agadu
    Notify presenter that view is ready
    */
   
   func viewIsReady()
   
   func dismiss()
   
   func userRegistration(email: String, password: String)
}
