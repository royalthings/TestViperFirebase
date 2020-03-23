//
//  LoginLoginInteractorInput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol LoginInteractorInput {
   
   func userLogin(email: String, password: String)
   
   func userIsAlreadyLogged()

}
