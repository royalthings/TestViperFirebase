//
//  RegistrationRegistrationRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class RegistrationRouter: RegistrationRouterInput {
   
   
   weak var viewController: RegistrationViewController!
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
}
