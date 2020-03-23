//
//  AddPlaceAddPlaceRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

class AddPlaceRouter: AddPlaceRouterInput {
   
   weak var viewController: AddPlaceViewController!
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
}
