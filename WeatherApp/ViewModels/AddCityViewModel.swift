//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AddCityViewModel : NSObject {
    var selectedCity: ((_ cityInfoObj: CityInfoModel) -> Void)?
    var updateErrorStatus: ((_ errorMessage : String) -> Void)?

    let locationManager = CLLocationManager()
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var selectedLocation :[String:AnyObject] = [:]
    var isValidAddress : Bool!
    var mapView : MKMapView?
    var currentLocation : CLLocation?

    override init() {
        super.init()
    }
    
    func initialSetup(mapView : MKMapView)
    {
        self.mapView = mapView
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10.0
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.pointAnnotation = MKPointAnnotation()

    }
    func addCityOnMap() {
        if currentLocation != nil
        {
            let cityModelObj = CityInfoModel(cityName: selectedLocation.getStringValue(key: KeyNames.kUserCity), latitude: currentLocation?.coordinate.latitude, longitude: currentLocation?.coordinate.longitude, countryName: selectedLocation.getStringValue(key: KeyNames.kUserCountryCode), stateName: selectedLocation.getStringValue(key: KeyNames.kUserStateCode))
        self.selectedCity!(cityModelObj)
        }
        else{
            self.updateErrorStatus?("Please enable location service.")
        }

    }
    
    func updateUserOnMap()
    {
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude:(currentLocation?.coordinate.longitude)!)

        self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)

        self.pinAnnotationView.image = UIImage(named: "PinImage")
        let viewRegion = MKCoordinateRegion(center: self.pointAnnotation.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        self.mapView?.setRegion(viewRegion, animated: true)
        //self.mapView.centerCoordinate = self.pointAnnotation.coordinate
        self.mapView?.addAnnotation(self.pinAnnotationView.annotation!)
        
        getAddressFromLatLon(pdblLatitude: (currentLocation?.coordinate.latitude)!, withLongitude: (currentLocation?.coordinate.longitude)!)

    }

}

extension AddCityViewModel : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        self.updateUserOnMap()
        
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 0.01
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 0.0001, longitudinalMeters: regionRadius * 0.0001)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error.localizedDescription:\(error.localizedDescription)")
    }
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat:Double   = pdblLatitude
        let lon : Double = pdblLongitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        if let pm = placemarks
                                        {
                                            
                                            if pm.count > 0 {
                                                let pm = placemarks![0]
                                                var addressString : String = ""
                                                if pm.name != nil {
                                                    addressString = addressString + pm.name! + ", "
                                                }
                                                if pm.subLocality != nil {
                                                    addressString = addressString + pm.subLocality! + ", "
                                                }
                                                if pm.thoroughfare != nil {
                                                    addressString = addressString + pm.thoroughfare! + ", "
                                                }
                                                if pm.locality != nil {
                                                    
                                                    addressString = addressString + pm.locality! + ", "
                                                }
                                                if pm.country != nil {
                                                    addressString = addressString + pm.country! + ", "
                                                }
                                                if pm.postalCode != nil {
                                                    addressString = addressString + pm.postalCode! + " "
                                                }
                                                
                                                self.pointAnnotation.title = addressString
                                                
                                                let addressObj : [String:AnyObject]  = pm.addressDictionary as! [String : AnyObject]
                                                
                                                self.selectedLocation[KeyNames.kUserCity] = addressObj.getStringValue(key:KeyNames.kUserCity) as AnyObject
                                                self.selectedLocation[KeyNames.kUserCountryCode] = addressObj.getStringValue(key: KeyNames.kUserCountryCode) as AnyObject
                                                self.selectedLocation[KeyNames.kUserStateCode] = addressObj.getStringValue(key:KeyNames.kUserStateCode) as AnyObject
                                                
                                                self.isValidAddress = true
                                                
                                            }
                                        }
                                    })
        
    }
    
}
extension AddCityViewModel : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState){
        
        let currentAnnotationLattitude = view.annotation?.coordinate.latitude
        
        let currentAnnotationLongitude = view.annotation?.coordinate.longitude
        
        getAddressFromLatLon(pdblLatitude: currentAnnotationLattitude!, withLongitude: currentAnnotationLongitude!)
        
        
    }
    
}
