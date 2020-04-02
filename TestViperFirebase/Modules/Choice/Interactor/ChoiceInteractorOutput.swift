//
//  ChoiceChoiceInteractorOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol ChoiceInteractorOutput: class {
   
   func isSignOut(_ isSignOut: Bool)
   
   func saveName(userName: String)

}
