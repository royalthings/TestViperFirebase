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
   
   var place: Place!
   var output: MapViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
      
      locationManager.delegate = self
   }

   // MARK: MapViewInput
   func setupInitialState() {
      
   }
   
   func displayPlaceOnMap(_ placeModel: Place) {
      DispatchQueue.main.async {
         self.place = placeModel
         let latitude = placeModel.coordinate.latitude
         let longitude = placeModel.coordinate.longitude
         
         self.destLatitude = latitude
         self.destLongitude = longitude
         
         let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
         self.centerMapOnLocation(location: initialLocation)
         
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
         centerMapOnLocation(location: location)
      }
   }
   
   //MARK: - MapView
   
   func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      placeMapView.setRegion(coordinateRegion, animated: true)
   }
   
//   func foundTap(_ recognizer: UITapGestureRecognizer) {
//      let point: CGPoint = recognizer.location(in: placeMapView)
//      let tapPoint: CLLocationCoordinate2D = placeMapView.convert(point, toCoordinateFrom: view)
//      let point1 = MKPointAnnotation()
//      point1.coordinate = tapPoint
//      placeMapView.addAnnotation(point1)
//      let getLat: CLLocationDegrees = tapPoint.latitude
//      let getLon: CLLocationDegrees = tapPoint.longitude
//      let locationTouch: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
//      
//      print(getLat)
//      print(getLon)
//      //       coordinateToAdress(locationTouch)
//   }
}

//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      if annotation is MKUserLocation {
         return nil
      }
      let identifire = "annotationView"
      var view: MKAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifire) {
         dequeuedView.image = UIImage(named: "iconsPin50")
         dequeuedView.annotation = annotation
         view = dequeuedView
      } else {
         view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifire)
         view.image = UIImage(named: "iconsPin50")
         view.canShowCallout = true
         
         //add custom annotation button
         let mapButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
         mapButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: .normal)
         view.rightCalloutAccessoryView = mapButton
      }
      // add long detail
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = place.discipline
      view.detailCalloutAccessoryView = detailLabel
      
      return view
   }
   
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      let location = view.annotation as! Place
      let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
      location.mapItem().openInMaps(launchOptions: launchOptions)
   }
}

extension MapViewController: CLLocationManagerDelegate {
   
   // Handle authorization for the location manager.
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .authorizedWhenInUse:
         placeMapView.showsUserLocation = true
         if let location = locationManager.location {
            centerMapOnLocation(location: location)
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


