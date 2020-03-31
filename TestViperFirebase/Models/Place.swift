//
//  Place.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 3/2/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Place: NSObject, MKAnnotation {
   let title: String?
   let discipline: String?
   let coordinate: CLLocationCoordinate2D
   let placeId: String?
   let userId: String?
   let isVisit: Bool
   
   init(title: String?, discipline: String?, coordinate: CLLocationCoordinate2D, placeId: String, userId: String, isVisit: Bool) {
      self.title = title
      self.discipline = discipline
      self.coordinate = coordinate
      self.placeId = placeId
      self.userId = userId
      self.isVisit = isVisit
   }
   
   func mapItem() -> MKMapItem {
      let addressDict = [CNPostalAddressStreetKey: title]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
   }
}
