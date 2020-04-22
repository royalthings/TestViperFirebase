//
//  ChoiceChoiceViewOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 14/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//
import UIKit

protocol ChoiceViewOutput {
   
   /**
    @author agadu
    Notify presenter that view is ready
    */
   
   func viewIsReady()
   
   func signOut()
   
   func goToMainScreen()
   
   func goToMapScreen()
   
   func obtainUserData(email: String?)
}
