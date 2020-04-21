//
//  RegistrationRegistrationInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class RegistrationInteractor: RegistrationInteractorInput {
   
   weak var output: RegistrationInteractorOutput!
   var dataManager = DataManager()
   
   func userRegistration(email: String, name: String, password: String, city: String) {
      dataManager.registration(email: email, name: name, password: password, city: city) { (isRegistered) in
         self.output.userRegistered(isRegistered)
      }
   }
   
}
