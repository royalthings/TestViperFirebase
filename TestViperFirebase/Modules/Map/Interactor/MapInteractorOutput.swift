//
//  MapMapInteractorOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol MapInteractorOutput: class {
   
   func displayRandomPlace(_ places: [Place])
   
   func savePlaces(_ places: [Place])

}
