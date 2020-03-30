//
//  MapMapViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 02/03/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MapViewInput {

   @IBOutlet weak var placeMapView: MKMapView!
   
   fileprivate let locationManager = CLLocationManager()
   fileprivate let autorizationStatus = CLLocationManager.authorizationStatus()
   fileprivate let regionRadius: Double = 500.0
   fileprivate var destLatitude: CLLocationDegrees?
   fileprivate var destLongitude: CLLocationDegrees?
   
   var places: [Place] = []
   var newCoordinate: CLLocationCoordinate2D!
   
   var place: Place!
   var output: MapViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      locationManager.delegate = self
      
      longPress()
   }
   
   override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       
       setupInitialState()
   }

   fileprivate func longPress() {
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mapLongPress(_:)))
      longPress.minimumPressDuration = 1
      placeMapView.addGestureRecognizer(longPress)
   }
   
   @objc func mapLongPress(_ recognizer: UIGestureRecognizer) {
      removePin()
      place = nil
      let touchedAt = recognizer.location(in: placeMapView)
      let touchedAtCoordinate: CLLocationCoordinate2D = placeMapView.convert(touchedAt, toCoordinateFrom: placeMapView)
      let newPin = MKPointAnnotation()
      newCoordinate = touchedAtCoordinate
      newPin.coordinate = touchedAtCoordinate
      newPin.title = "Do you want to add a new place?"
      placeMapView.addAnnotation(newPin)
      centerMapOnLocation(locationCoordinate: touchedAtCoordinate)
   }

   // MARK: MapViewInput
   func setupInitialState() {
      output.featchAllPlaces()
   }
   
   func savePlaces(_ place: [Place]) {
      places = place
   }
   
   func displayPlaceOnMap(_ placeModel: Place) {
      DispatchQueue.main.async {
         self.place = placeModel
         let latitude = placeModel.coordinate.latitude
         let longitude = placeModel.coordinate.longitude
         
         self.destLatitude = latitude
         self.destLongitude = longitude
         
         let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
         self.centerMapOnLocation(locationCoordinate: initialLocation.coordinate)
         
         self.placeMapView.addAnnotation(self.place)
      }
   }
   
   fileprivate func removePin() {
      for annotation in placeMapView.annotations {
         placeMapView.removeAnnotation(annotation)
      }
   }
   
   func displayRandomPlace(_ place: Place) {
      displayPlaceOnMap(place)
   }
   
   @IBAction func backAction(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
   }
   
   @IBAction func goAction(_ sender: Any) {
      removePin()
      output.getRandomPlace()
   }
   
   @IBAction func centerMapAction(_ sender: Any) {
      if let location = locationManager.location {
         centerMapOnLocation(locationCoordinate: location.coordinate)
      }
   }
   
   //MARK: - MapView
   
   func centerMapOnLocation(locationCoordinate: CLLocationCoordinate2D) {
      let coordinateRegion = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      placeMapView.setRegion(coordinateRegion, animated: true)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      output.prepare(segue)
   }
}

//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      if annotation is MKUserLocation {
         return nil
      }
      let identifire = "annotationView"
      var view: MKAnnotationView
      
      let mapRightButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      let mapLeftButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifire) {
         dequeuedView.image = UIImage(named: "iconsPin50")
         dequeuedView.annotation = annotation
         view = dequeuedView

         //add custom annotation button
         if place == nil {
            for element in places {
               if newCoordinate.latitude != element.coordinate.latitude && newCoordinate.longitude != element.coordinate.longitude {
                  mapRightButton.setBackgroundImage(UIImage(named: "plus"), for: .normal)
               } else {
                  mapRightButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: .normal)
               }
            }
         } else {
            mapRightButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: .normal)
            mapLeftButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
            view.leftCalloutAccessoryView = mapLeftButton
         }
         view.rightCalloutAccessoryView = mapRightButton
      } else {
         view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifire)
         view.image = UIImage(named: "iconsPin50")
         view.canShowCallout = true
         
         //add custom annotation button
         mapRightButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: .normal)
         view.rightCalloutAccessoryView = mapRightButton         
      }
      
      return view
   }
   
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      if place != nil {
         let location = view.annotation as! Place
         let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
         location.mapItem().openInMaps(launchOptions: launchOptions)
      } else {
         output.addNewPlace()
      }
   }
}

extension MapViewController: CLLocationManagerDelegate {
   
   // Handle authorization for the location manager.
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .authorizedWhenInUse:
         placeMapView.showsUserLocation = true
         if let location = locationManager.location {
            centerMapOnLocation(locationCoordinate: location.coordinate)
         }
         locationManager.startUpdatingLocation()
         print("Location status is OK.")
      case .denied:
         print("User denied access to location.")
         //TODO: - Show alert
         break
      case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
         print("Location status not determined.")
      case .restricted:
         print("Location access was restricted.")
         //TODO: - Show alert
         break
      case .authorizedAlways:
         break
      }
   }
   
   // Handle location manager errors.
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      locationManager.stopUpdatingLocation()
      print("Error: \(error)")
   }
}


