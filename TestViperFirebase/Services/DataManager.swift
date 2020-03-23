//
//  DataManager.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 3/2/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//


import Foundation
import Firebase
import FirebaseAuth
import MapKit

protocol DataManagerProtocol {
   
   func getPlaces(handler: @escaping (_ returnedPlaces: [Place]) -> ())
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, handler: @escaping (_ isAdded: Bool) -> ())
   func delete(withId id: String, handler: @escaping (_ isDelete: Bool) -> ())
   
   func login(email: String, password: String, handler: @escaping (_ userName: String) -> ())
   func registration(email: String, password: String, handler: @escaping (_ resultLogin: Bool) -> ())
   func userIsAlreadyLogged(handler: @escaping (_ IsAlreadyLogged: Bool, _ username: String) -> ())
   func signOut(handler: @escaping (Bool) -> ())
}

let DB_BASE = Database.database().reference()

class DataManager: DataManagerProtocol {
   
   static let instance = DataManager()
   
   private var _REF_BASE = DB_BASE
   private var _REF_PLACES = DB_BASE.child("places")
   private var _REF_USER = DB_BASE.child("user")
   
   var REF_BASE: DatabaseReference {
      return _REF_BASE
   }
   var REF_PLACES: DatabaseReference {
      return _REF_PLACES
   }
   
   var REF_USER: DatabaseReference {
      return _REF_USER
   }
   
   func getPlaces(handler: @escaping (_ returnedPlaces: [Place]) -> ()) {
      var placeArray = [Place]()
      
      REF_PLACES.observeSingleEvent(of: .value) { (placeSnapshot) in
         guard let placeSnapshot = placeSnapshot.children.allObjects as? [DataSnapshot] else { return }
         for place in placeSnapshot {
            let title = place.childSnapshot(forPath: "title").value as! String
            let discipline = place.childSnapshot(forPath: "discipline").value as! String
            let latitude = place.childSnapshot(forPath: "latitude").value as! CLLocationDegrees
            let longitude = place.childSnapshot(forPath: "longitude").value as! CLLocationDegrees
            let placeId = place.childSnapshot(forPath: "placeId").value as! String
            let userId = place.childSnapshot(forPath: "userId").value as! String
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let place = Place(title: title, discipline: discipline, coordinate: coordinate, placeId: placeId, userId: userId)
            if userId == Auth.auth().currentUser?.uid {
               placeArray.append(place)
            }
         }
         handler(placeArray)
      }
   }
   
   func login(email: String, password: String, handler: @escaping (_ userName: String) -> ()) {
      Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
         if error != nil {
            print(error as Any)
            handler("")
            return
         }
         if user != nil {
            handler(email)
         }
      }
   }
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, handler: @escaping (_ isAdded: Bool) -> ()) {
      
      guard let latitudeFloat = Float(latitude) else { return }
      guard let longitudeFloat = Float(longitude) else { return }
      
      let newPlace = REF_PLACES.childByAutoId()
      let userId = Auth.auth().currentUser?.uid
      
      let plase: Dictionary<String, Any> = ["title": title, "discipline": discipline, "latitude": latitudeFloat, "longitude": longitudeFloat, "placeId": newPlace.key as Any, "userId": userId as Any]
      
      newPlace.setValue(plase)
      
      handler(true)
   }
   
   func delete(withId id: String, handler: @escaping (_ isDelete: Bool) -> ()) {
      REF_PLACES.child(id).removeValue { (error, referens) in
         if error != nil {
            print(error as Any)
            handler(false)
         }
         handler(true)
      }
   }
   
   func registration(email: String, password: String, handler: @escaping (Bool) -> ()) {
      
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
         
         if error != nil {
            print(error as Any)
            handler(false)
            return
         }
         if user != nil {
            let userId = self.REF_USER.childByAutoId()
            let user: Dictionary<String, Any> = ["email": email, "password": password]
            userId.setValue(user)
            
            handler(true)
         }
      }
   }
   
   func userIsAlreadyLogged(handler: @escaping (Bool, String) -> ()) {
      Auth.auth().addStateDidChangeListener { (auth, user) in
         if user != nil {
            guard let userName = user?.email else { return }
            handler(true, userName)
         } else {
            handler(false, "")
         }
      }
   }
   
   func signOut(handler: @escaping (Bool) -> ()) {
      do {
         try Auth.auth().signOut()
         handler(true)
      } catch let error {
         print(error)
         handler(false)
      }
   }
}
