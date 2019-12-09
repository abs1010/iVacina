//
//  MapsLocals.swift
//  iVacina
//
//  Created by Marcela Limieri Tozzato on 11/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import MapKit

struct ArrayMedicalCenters: Codable {
    let total: Int
    let businesses: [MedicalCenter]
    let region: Region
}

struct MedicalCenter: Codable {
    let rating: Double
    let phone: String
    let id: String
    let alias: String
    let isClosed: Bool
    let categories: [Category]
    let reviewCount: Int
    let name: String
    let url: String
    let coordinates: Center
    let imageURL: String
    let location: Location
    let distance: Double
    let transactions: [String]
    

    enum CodingKeys: String, CodingKey {
        case rating, id, alias, phone
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}

struct Category: Codable {
    let alias, title: String
}

struct Center: Codable {
    let latitude, longitude: Double
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

struct Location: Codable {
    let city, country: String
    let state, address1, zipCode: String

    enum CodingKeys: String, CodingKey {
        case city, country, state, address1
        case zipCode = "zip_code"
    }
}

struct Region: Codable {
    let center: Center
}



class MapsLocals: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
    
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    
    super.init()
        
    }
    
    init(json: MedicalCenter){
        
        self.title = json.name
        self.subtitle = json.location.address1
        self.coordinate = json.coordinates.coordinate
    }
}
