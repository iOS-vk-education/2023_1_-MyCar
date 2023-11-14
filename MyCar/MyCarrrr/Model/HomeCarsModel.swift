//
//  HomeCarsModel.swift
//  MyCarrrr
//
//  Created by Anton Sharin on 13.11.2023.
//

import Foundation

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = []
    
    private let networkService = NetworkService()
    
    func loadCars() {
        // user defaults get
    }
    
    func carDataFromVin(vin: String) {
        networkService.homePageCall { result in
            switch result {
            case .success(let success):
                self.cars.append(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func remove(at index: Int) {
        cars.remove(at: index)
    }
    
    func car(index: Int) -> CarViewModel {
        cars[index]
    }
    
    func addCar(_ car: CarViewModel) {
        cars.append(car)
    }
    
    func allCars() -> [CarViewModel] {
        cars
    }
}
