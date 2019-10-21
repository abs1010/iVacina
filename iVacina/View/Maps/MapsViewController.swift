//
//  MapsViewController.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 18/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    var localizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapa.delegate = self
        
        //Solicitar acesso ao GPS:
        self.localizacao.requestWhenInUseAuthorization()
        
    }
    
    
    @IBAction func clicouLocalizacaoAtual(_ sender: UIButton) {
        
        //Pegar a localição do usuário:
        self.localizacao.desiredAccuracy = kCLLocationAccuracyBest
        
        //Monitorar a localização do usuário:
        self.localizacao.startUpdatingLocation()
        
        
        //Pegar latitude e longitude da localização do usuário:
        let latitude = Double((localizacao.location?.coordinate.latitude)  ?? 0.0)
        let longitude = Double((localizacao.location?.coordinate.longitude) ?? 0.0)
        
        //Definir o centro e o zoom da exibição:
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //Exibir a localização do usuário:
        let exibirLocalizacao = MKCoordinateRegion(center: center, span: span)
        self.mapa.setRegion(exibirLocalizacao, animated: true)
    }
}



