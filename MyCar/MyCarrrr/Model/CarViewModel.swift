//
//  CarViewModel.swift
//  MyCarrrr
//
//  Created by Anton Sharin on 13.11.2023.
//

import Foundation

struct CarViewModel: Codable {
    let manufacturer: String
    let milleage: Int
    let purchaseDate: String
    let vinNumber: String
    
}

struct TO {
    let price: Int
    let date: String
}

struct CarMain {
    let info: CarViewModel
    let to: [TO]
}
