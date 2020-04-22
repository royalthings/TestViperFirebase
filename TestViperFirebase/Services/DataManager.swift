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
   func getUserPlaces(handler: @escaping (_ returnedPlaces: [Place]) -> ())
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, city: String, handler: @escaping (_ isAdded: Bool) -> ())
   func delete(withId id: String, handler: @escaping (_ isDelete: Bool) -> ())
   func selectAsVisit(withId id: String, handler: @escaping (_ isSelect: Bool) -> ())
   func deselectAsVisit(withId id: String, handler: @escaping (_ isSelect: Bool) -> ())
   
   func login(email: String, password: String, handler: @escaping (_ userName: String) -> ())
   func registration(email: String, name: String, password: String, city: String, handler: @escaping (_ resultLogin: Bool) -> ())
   func userIsAlreadyLogged(handler: @escaping (_ IsAlreadyLogged: Bool, _ username: String) -> ())
   func signOut(handler: @escaping (Bool) -> ())
   
   func obtainUserData(email: String?, handler: @escaping (_ returnedUserName: String, _ returnedUserCity: String) -> ())
   //func obtainUserCity(email: String?, handler: @escaping (_ returnedUserCity: String) -> ())
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
            let isVisit = place.childSnapshot(forPath: "isVisit").value as! Bool
            let city = place.childSnapshot(forPath: "city").value as! String
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let place = Place(title: title, discipline: discipline, coordinate: coordinate, placeId: placeId, userId: userId, isVisit: isVisit, city: city)
            if userId == Auth.auth().currentUser?.uid || userId == "0" {
               if city == UserDefaults.standard.string(forKey: Constants.Keys.userCity) {
                  placeArray.append(place)
               }
            }
         }
         handler(placeArray)
      }
   }
   
   func getUserPlaces(handler: @escaping (_ returnedPlaces: [Place]) -> ()) {
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
            let isVisit = place.childSnapshot(forPath: "isVisit").value as! Bool
            let city = place.childSnapshot(forPath: "city").value as! String
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let place = Place(title: title, discipline: discipline, coordinate: coordinate, placeId: placeId, userId: userId, isVisit: isVisit, city: city)
            if userId == Auth.auth().currentUser?.uid {
               if city == UserDefaults.standard.string(forKey: Constants.Keys.userCity) {
                  placeArray.append(place)
               }
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
   
   func addNewPlace(title: String, discipline: String, latitude: String, longitude: String, city: String, handler: @escaping (_ isAdded: Bool) -> ()) {
      
      guard let latitudeFloat = Float(latitude) else { return }
      guard let longitudeFloat = Float(longitude) else { return }
      
      let newPlace = REF_PLACES.childByAutoId()
      let userId = Auth.auth().currentUser?.uid
      let isVisit = false
      
      let plase: Dictionary<String, Any> = ["title": title, "discipline": discipline, "latitude": latitudeFloat, "longitude": longitudeFloat, "placeId": newPlace.key as Any, "userId": userId as Any, "isVisit": isVisit, "city": city]
      
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
   
   func selectAsVisit(withId id: String, handler: @escaping (_ isSelect: Bool) -> ()) {
      REF_PLACES.child(id).child("isVisit").setValue(true) { (error, referens) in
         if error != nil {
            print(error as Any)
            handler(false)
         }
         handler(true)
      }
   }
   
   func deselectAsVisit(withId id: String, handler: @escaping (_ isSelect: Bool) -> ()) {
      REF_PLACES.child(id).child("isVisit").setValue(false) { (error, referens) in
         if error != nil {
            print(error as Any)
            handler(false)
         }
         handler(true)
      }
   }
   
   func registration(email: String, name: String, password: String, city: String, handler: @escaping (Bool) -> ()) {
      
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
         
         if error != nil {
            print(error as Any)
            handler(false)
            return
         }
         if user != nil {
            let userId = self.REF_USER.childByAutoId()
            let user: Dictionary<String, Any> = ["email": email, "name": name, "password": password, "city": city]
            
//            let test = User(email: email, name: name, password: password)
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
   
   func obtainUserData(email: String?, handler: @escaping (_ returnedUserName: String, _ returnedUserCity: String) -> ()) {
      var userName = ""
      var userCity = ""
      REF_USER.observeSingleEvent(of: .value) { (userSnapshot) in
         
         guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
         for user in userSnapshot {
            let name = user.childSnapshot(forPath: "name").value as! String
            let city = user.childSnapshot(forPath: "city").value as! String
            let userEmail = user.childSnapshot(forPath: "email").value as! String
            if userEmail == email {
               userName = name
               userCity = city
            }
         }
         handler(userName, userCity)
      }
   }
   
//   func obtainUserCity(email: String?, handler: @escaping (_ returnedUserCity: String) -> ()) {
//      var userCity = ""
//      REF_USER.observeSingleEvent(of: .value) { (userSnapshot) in
//
//         guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
//         for user in userSnapshot {
//            let city = user.childSnapshot(forPath: "city").value as! String
//            let userEmail = user.childSnapshot(forPath: "email").value as! String
//            if userEmail == email {
//               userCity = city
//            }
//         }
//         handler(userCity)
//      }
//   }

}
