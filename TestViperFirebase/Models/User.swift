//
//  User.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 3/13/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//

import Foundation

class User {
   let email: String
   let name: String
   let password: String
   
   init(email: String, name: String, password: String) {
      self.email = email
      self.name = name
      self.password = password
   }
}
