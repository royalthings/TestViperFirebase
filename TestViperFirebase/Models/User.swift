//
//  User.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 3/13/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//

import Foundation
import CryptoSwift

class User {
   let email: String
   let name: String
   let password: String
   
   init(email: String, name: String, password: String) {
      self.email = email
      self.name = name
      self.password = password
   }
   
   class func passwordHash(from email: String, password: String) -> String {
      let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
      return "\(password).\(email).\(salt)".sha256()
   }
}
