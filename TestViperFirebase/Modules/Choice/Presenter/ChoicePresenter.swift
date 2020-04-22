//
//  ChoiceChoicePresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class ChoicePresenter: ChoiceModuleInput, ChoiceViewOutput, ChoiceInteractorOutput {

   weak var view: ChoiceViewInput!
   var interactor: ChoiceInteractorInput!
   var router: ChoiceRouterInput!
   
   func viewIsReady() {
      
   }
   
   func signOut() {
      interactor.signOut()
   }
   
   func isSignOut(_ isSignOut: Bool) {
      if isSignOut {
         router.dismissToLoginScreen()
      } else {
         view.showError(title: "Error", message: "Error SignOut")
      }
   }
   
   func goToMainScreen() {
      router.goToMainScreen()
   }
   
   func goToMapScreen() {
      router.goToMapScreen()
   }
   
   func obtainUserData(email: String?) {
      interactor.obtainUserData(email: email)
   }
   
   func saveData(userName: String, userCity: String) {
      view.saveData(userName: userName, userCity: userCity)
   }

}
