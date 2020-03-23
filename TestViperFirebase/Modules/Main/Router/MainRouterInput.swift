//
//  MainMainRouterInput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

protocol MainRouterInput {
   
   func goToMapScreen()
   
   func passDataToMap(_ segue: UIStoryboardSegue)

   func goToAddNewPlaceScreen()
   
   func dismiss()
}
