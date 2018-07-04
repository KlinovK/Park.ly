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
    
}

extension ViewController: CLLocationManagerDelegate{
    
}
