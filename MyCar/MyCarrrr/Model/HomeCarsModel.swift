import Foundation

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = []

    
    private let networkService = NetworkService()
    
    func loadCars() {
        // user defaults get
    }
    
    
    func carDataFromVin(vin: String, completion: @escaping (String?, String?, Int?) -> Void) {
        networkService.homePageCall { result in
            switch result {
            case .success(let car):
                let manufacturer = car.make.name
                let model = car.model.name
                let year = car.years.first?.year
//                print(car.years.first?.year ?? "year")
                completion(manufacturer, model, year)
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
