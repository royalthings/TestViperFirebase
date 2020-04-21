//
//  AddPlaceAddPlaceInteractorInput.swift
//  TestViperFirebase
//
//  Created by agadu on 03/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import Foundation

protocol AddPlaceInteractorInput {
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, city: String)

}
