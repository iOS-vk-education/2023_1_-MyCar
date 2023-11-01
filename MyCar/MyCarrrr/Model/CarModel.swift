//
//  CarModel.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 01.11.2023.
//

class Car {
    var brand: String
    var model: String
    var year: Int
    var mileage: Int
    var color: String
    var vinNumber: Int
    
    init(brand: String, model: String, year: Int, mileage: Int, color: String, vinNumber: Int) {
        self.brand = brand
        self.model = model
        self.year = year
        self.mileage = mileage
        self.color = color
        self.vinNumber = vinNumber
    }
}
