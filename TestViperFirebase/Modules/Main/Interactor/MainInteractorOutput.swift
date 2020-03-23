//
//  MainMainInteractorOutput.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol MainInteractorOutput: class {

   func displayAllPlaces(_ places: [Place])
   
   func isDelete(_ isDelete: Bool)
}
