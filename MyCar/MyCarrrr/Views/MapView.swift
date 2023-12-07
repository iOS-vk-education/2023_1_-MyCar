//
//  MapView.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 06.12.2023.
//

import UIKit
import MapKit

class MapView: UIView {
    
    let map = MKMapView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .yellow
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMap() {
        self.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            map.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            map.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            map.widthAnchor.constraint(equalToConstant: 400),
            map.heightAnchor.constraint(equalToConstant: 800)
        ])
        
    }
}
