//
//  ChoiceChoiceRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class ChoiceRouter: ChoiceRouterInput {

   weak var viewController: ChoiceViewController!
   
   func goToMainScreen() {
      viewController.performSegue(withIdentifier: "showPlaces", sender: nil)
   }
   
   func goToMapScreen() {
      viewController.performSegue(withIdentifier: "showRandomMap", sender: nil)
   }
   
   func dismissToLoginScreen() {
      viewController.dismiss(animated: true, completion: nil)
   }

}
