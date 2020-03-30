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
      
      var annotationView: MKAnnotationView!
      let identifire = "annotationView"
      let newIdentifire = "newAnnotationView"
      var imageName = ""
      
      
      
      if place == nil {
         for element in places {
            if newCoordinate.latitude != element.coordinate.latitude && newCoordinate.longitude != element.coordinate.longitude {
               imageName = "plus"
            } else {
               imageName = "Maps-icon"
            }
         }
      } else {
         imageName = "Maps-icon"
      }
      
      if place == nil {
         annotationView = addRightButtonAnnotation(mapView, annotation: annotation, identifire: newIdentifire, imageName: imageName)
      } else {
         annotationView = addRightAndLeftButtonAnnotation(mapView, annotation: annotation, identifire: identifire, imageName: imageName)
      }
      return annotationView
   }
   
   fileprivate func addRightButtonAnnotation(_ mapView: MKMapView, annotation: MKAnnotation, identifire: String, imageName: String) -> MKAnnotationView {
      let mapRightButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      
      var view: MKAnnotationView
      
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifire) {
         dequeuedView.image = UIImage(named: "iconsPin50")
         dequeuedView.annotation = annotation
         view = dequeuedView
         mapRightButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
         view.rightCalloutAccessoryView = mapRightButton
      } else {
         view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifire)
         view.image = UIImage(named: "iconsPin50")
         view.canShowCallout = true
         mapRightButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
         view.rightCalloutAccessoryView = mapRightButton
      }
      return view
   }
   
   fileprivate func addRightAndLeftButtonAnnotation(_ mapView: MKMapView, annotation: MKAnnotation, identifire: String, imageName: String) -> MKAnnotationView {
      let mapRightButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      let mapLeftButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
      var view: MKAnnotationView
      
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifire) {
         dequeuedView.image = UIImage(named: "iconsPin50")
         dequeuedView.annotation = annotation
         view = dequeuedView
         mapRightButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
         view.rightCalloutAccessoryView = mapRightButton
         
         mapLeftButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
         view.leftCalloutAccessoryView = mapLeftButton
      } else {
         view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifire)
         view.image = UIImage(named: "iconsPin50")
         view.canShowCallout = true
         mapRightButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
         view.rightCalloutAccessoryView = mapRightButton
         
         mapLeftButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
         view.leftCalloutAccessoryView = mapLeftButton
      }
      return view
   }

   
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      
      if control == view.rightCalloutAccessoryView {
         if place != nil {
            let location = view.annotation as! Place
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMaps(launchOptions: launchOptions)
         } else {
            output.addNewPlace()
         }
      } else if control == view.leftCalloutAccessoryView {
         output.showDetail()
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


