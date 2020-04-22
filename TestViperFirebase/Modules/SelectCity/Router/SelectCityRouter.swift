//
//  SelectCitySelectCityRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 22/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class SelectCityRouter: SelectCityRouterInput {
   
   weak var viewController: SelectCityViewController!
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
}
