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

class MapsViewController: UIViewController {
    
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var wazeBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    let zoomInMeters: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        displayView(enable: false)
        
        mapView.delegate = self

    }
    
    @IBAction func tappedWazeBtn(_ sender: UIButton) {
        
        
    }
    
    
    func displayView(enable: Bool){
        self.detailView.isHidden = !enable
        self.titleLbl.isHidden = !enable
        self.wazeBtn.isHidden = !enable
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
        
        if let currentLocation = locationManager.location?.coordinate{
        MapsController().getMedicalCenters(latitude: (currentLocation.latitude), longitude: (currentLocation.longitude)) { (array, error) in
            
            if let arrayLocals = array {
                self.mapView.addAnnotations(arrayLocals)
            }
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
    
}

extension MapsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
        displayView(enable: true)
        titleLbl.text = view.annotation?.title ?? ""
        
    }
}
































