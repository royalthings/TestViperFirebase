//
//  RegistrationRegistrationPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class RegistrationPresenter: RegistrationModuleInput, RegistrationViewOutput, RegistrationInteractorOutput {

   weak var view: RegistrationViewInput!
   var interactor: RegistrationInteractorInput!
   var router: RegistrationRouterInput!
   
   func viewIsReady() {
      
   }
   
   func dismiss() {
      router.dismiss()
   }
   
   func userRegistration(email: String, name: String, password: String, city: String) {
      interactor.userRegistration(email: email, name: name, password: password, city: city)
   }
   
   func userRegistered(_ isRegistered: Bool) {
      if isRegistered {
         router.dismiss()
         view.cleanTextFields()
      } else {
         view.showError(title: "Error", message: "User not registered")
         view.cleanTextFields()
      }
   }
}
