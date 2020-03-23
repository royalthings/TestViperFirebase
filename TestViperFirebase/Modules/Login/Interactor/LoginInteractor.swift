//
//  LoginLoginInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class LoginInteractor: LoginInteractorInput {

   weak var output: LoginInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func userLogin(email: String, password: String) {
      dataManager.login(email: email, password: password) { (userName) in
         self.output.goToNextScreen(userName)
      }
   }
   
   func userIsAlreadyLogged() {
      dataManager.userIsAlreadyLogged { (isAlreadyLogged, userName) in
         self.output.goToMainScreen(isAlreadyLogged, userName)
      }
   }
}
