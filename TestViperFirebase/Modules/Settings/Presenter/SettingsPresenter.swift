//
//  SettingsSettingsPresenter.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class SettingsPresenter: SettingsModuleInput, SettingsViewOutput, SettingsInteractorOutput {

   weak var view: SettingsViewInput!
   var interactor: SettingsInteractorInput!
   var router: SettingsRouterInput!
   
   func viewIsReady() {
      
   }

   func obtainUserData(email: String?) {
      interactor.obtainUserData(email: email)
   }
   
   func saveData(userName: String, userCity: String) {
      view.saveData(userName: userName, userCity: userCity)
   }
   
   func dismiss() {
      router.dismiss()
   }
   
}
