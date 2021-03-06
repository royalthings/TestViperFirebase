//
//  SettingsSettingsInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 19/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class SettingsInteractor: SettingsInteractorInput {
   
   weak var output: SettingsInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func obtainUserData(email: String?) {
      dataManager.obtainUserData(email: email) { (userName, userCity) in
         self.output.saveData(userName: userName, userCity: userCity)
      }
   }
   
}
