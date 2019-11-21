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
        
        
        self.getPostoDeSaude { (array, error) in
            
            if let arrayLocals = array {
                print(arrayLocals[26].coordinate)
                print(arrayLocals[27].coordinate)
                print(arrayLocals[28].coordinate)
                print(arrayLocals[29].coordinate)
                self.mapView.addAnnotations(arrayLocals)
            }
        }
    }
    
    func getPostoDeSaude(completion: @escaping completion<[MapsLocals]?>) {
        
        var arrayMapsLocals: [MapsLocals] = []
        
        MapsDataProvider().loadPostosDeSaude(latitude: -23.5615, longitude: -46.656, raio: 1000.0) { (response, error) in
            if let response = response {
                for value in response {
                    let currentPostoDeSaude = MapsLocals(json: value)
                    print (currentPostoDeSaude)
                    arrayMapsLocals.append(currentPostoDeSaude)
                }
                completion(arrayMapsLocals, false)
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
































