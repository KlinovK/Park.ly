//
//  ViewController.swift
//  Park.ly
//
//  Created by Константин Клинов on 7/2/18.
//  Copyright © 2018 Константин Клинов. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var parkBtn: RoundButton!
    @IBOutlet weak var maoView: MKMapView!
    
    let regionRadius: CLLocationDistance = 500
    var parkedCarAnnotation: ParkingSpot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maoView.delegate = self
        checkLocationAuthorizationStatus()
        
    }

  
    @IBAction func parkBtnWasPressed(_ sender: Any) {
        if maoView.annotations.count == 1 {
            parkBtn.setImage(UIImage(named: "foundCar.png"), for: .normal)
        } else {
            maoView.removeAnnotations(maoView.annotations)
            parkBtn.setImage(UIImage(named: "parkCar.png"), for: .normal)
        }
        centerMapOnLocation(location: LocationService.instance.locationManager.location!)
    }
    
    func checkLocationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            maoView.showsUserLocation = true
            LocationService.instance.locationManager.delegate = self
            LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationService.instance.locationManager.startUpdatingLocation()
            
        } else {
            LocationService.instance.locationManager.requestWhenInUseAuthorization()
            
        }
    }

    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        maoView.setRegion(coordinateRegion, animated: true)
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ParkingSpot {
        let identifier = "pin"
            var view: MKPinAnnotationView
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.animatesDrop = true
            view.pinTintColor = UIColor.orange
            view.calloutOffset = CGPoint(x: -8, y: -3)
            view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
            return view
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! ParkingSpot
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem(location: (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions: launchOptions)
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMapOnLocation(location: CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
        let locationServiceCoordinate = LocationService.instance.locationManager.location!.coordinate
        
        parkedCarAnnotation = ParkingSpot(title: "My Parking Spot", locationName: "Tap i for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
    }
}
