//
//  MapsViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import MapKit //mapa
import CoreLocation //localização do usuário

class MapsViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    let zoomInMeters: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        
        
        MapsController().getPostoDeSaude { (array, error) in
            
            if let arrayLocals = array {
                print(arrayLocals[1].coordinate)
                print(arrayLocals[2].coordinate)
                print(arrayLocals[3].coordinate)
                print(arrayLocals[4].coordinate)
                self.mapView.addAnnotations(arrayLocals)
            }
        }
    }
    
    
    
    func centerLocation() {
        if let currentLocation = locationManager.location?.coordinate{
            print(currentLocation)
            let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: zoomInMeters, longitudinalMeters: zoomInMeters)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func checkLocationAutorization(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                centerLocation()
                break
            case .denied:
                //alerta de erro
                break
            case .notDetermined:
                self.locationManager.requestAlwaysAuthorization()
                break
            case .restricted:
                //alerta de erro
                break
            case .authorizedAlways:
                break
            @unknown default:
                break
            }
        } else {
            //alerta de erro
        }
    }
}


extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
    
}
































