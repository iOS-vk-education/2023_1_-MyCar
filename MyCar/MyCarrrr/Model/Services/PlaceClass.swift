//
//  PlaceClass.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 07.12.2023.
//

import Foundation
import Foundation
import MapKit



class Place: NSObject, MKAnnotation {
    let title: String?
    let phone: String?
    let address: String?
    let coordinate: CLLocationCoordinate2D
    //let info: String
    
    init(title: String?, subtitle: String?, phone: String?, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.phone = phone
            self.address = subtitle
            self.coordinate = coordinate

            super.init()
    }
}

