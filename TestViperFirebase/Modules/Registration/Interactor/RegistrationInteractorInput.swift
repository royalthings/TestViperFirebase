//
//  RegistrationRegistrationInteractorInput.swift
//  TestViperFirebase
//
//  Created by agadu on 06/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol RegistrationInteractorInput {
   
   func userRegistration(email: String, name: String, password: String, city: String)

}
