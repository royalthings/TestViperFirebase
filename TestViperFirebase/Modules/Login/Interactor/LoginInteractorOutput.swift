//
//  LoginLoginInteractorOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol LoginInteractorOutput: class {
   
   func goToNextScreen(_ userName: String)
   
   func goToMainScreen(_ isAlreadyLogged: Bool, _ userName: String)

}
