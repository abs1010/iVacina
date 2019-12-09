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
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var wazeBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mapsController: MapsController?
    let locationManager: CLLocationManager = CLLocationManager()
    let zoomInMeters: CLLocationDistance = 1000
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapsController = MapsController()
        setupLocationManager()
        displayView(enable: false)
        
        mapView.delegate = self
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(hideDetailView))
        downSwipe.direction = .down
        
        self.detailView.addGestureRecognizer(downSwipe)
        
    }
    
    @IBAction func tappedWazeBtn(_ sender: UIButton) {
        if let location = mapsController?.selectedMKAnnotation?.annotation?.coordinate {
            callWazeApp(location: location)
        }
    }
    
    // URL scheme
    func callWazeApp(location: CLLocationCoordinate2D) {
        
        let latitude:Double = location.latitude
        let longitude:Double = location.longitude
        
        var link: String = "waze://"
        let url: URL = URL(string: link)!
        
        if UIApplication.shared.canOpenURL(url) {
            
            let urlStr:String = String(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:urlStr)!, options: [:], completionHandler: { (success) in
                    
                })
            } else {
                // Fallback on earlier versions
            }
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        } else {
            link = "https://itunes.apple.com/us/app/id323229106"
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:link)!, options: [:], completionHandler: { (success) in
                    
                })
            } else {
                // Fallback on earlier versions
            }
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
    
    @objc func hideDetailView() {
        self.displayView(enable: false)
    }
    
    func displayView(enable: Bool){
        self.detailView.isHidden = !enable
        self.titleLbl.isHidden = !enable
        self.wazeBtn.isHidden = !enable
        
        self.detailView.layer.cornerRadius = 30.0
        self.detailView.clipsToBounds = true
        self.detailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
            mapsController?.getMedicalCenters(latitude: (currentLocation.latitude), longitude: (currentLocation.longitude)) { (array, error) in
                
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
        displayView(enable: true)
        titleLbl.text = view.annotation?.title ?? ""
        addressLbl.text = view.annotation?.subtitle ?? ""
        mapsController?.selectedMKAnnotation = view
        
    }
}
































