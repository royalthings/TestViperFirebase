//
//  LoginLoginPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import  UIKit

class LoginPresenter: LoginModuleInput, LoginViewOutput, LoginInteractorOutput {

   weak var view: LoginViewInput!
   var interactor: LoginInteractorInput!
   var router: LoginRouterInput!
   
   func viewIsReady() {
      interactor.userIsAlreadyLogged()
   }
   
   func goToNextScreen(_ userName: String) {
      if userName != "" {
         router.goToNextScreen()
      }
   }
   
   func userIsLogin(email: String, password: String) {
      interactor.userLogin(email: email, password: password)
   }
   
   func registration() {
      router.goToRegistrationScreen()
   }
   
   func goToMainScreen(_ isAlreadyLogged: Bool, _ userName: String) {
      if isAlreadyLogged {
         view.setUserName(userName)
         router.goToNextScreen()
      }
   }
}
