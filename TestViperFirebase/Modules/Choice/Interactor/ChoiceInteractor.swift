//
//  ChoiceChoiceInteractor.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class ChoiceInteractor: ChoiceInteractorInput {
   
   weak var output: ChoiceInteractorOutput!
   var dataManager: DataManagerProtocol!
   
   func signOut() {
      dataManager.signOut {[weak self] (isSignOut) in
         self?.output.isSignOut(isSignOut)
      }
   }
   
   func obtainUserName(email: String?) {
      dataManager.obtainUserName(email: email) { (userName) in
         self.output.saveName(userName: userName)
      }
   }
   
}
