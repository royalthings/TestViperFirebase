//
//  DetailDetailRouter.swift
//  TestViperFirebase
//
//  Created by agadu on 30/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

class DetailRouter: DetailRouterInput {
   
   weak var viewController: DetailViewController!
   
   func dismiss() {
      viewController.dismiss(animated: true, completion: nil)
   }
}
