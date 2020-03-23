//
//  LoginLoginRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterInput {

   weak var viewController: LoginViewController!
   
   func goToNextScreen() {
       viewController.performSegue(withIdentifier: "showChoice", sender: nil)
   }
   
   func goToRegistrationScreen() {
      viewController.performSegue(withIdentifier: "showRegistration", sender: nil)
   }

}
