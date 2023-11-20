import Foundation

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = []
//    private var carsInfo : [CarInfo] = []
    
    private let networkService = NetworkService()
    
    func loadCars() {
        // user defaults get
    }
    
    
    func carDataFromVin(vin: String, completion: @escaping (String?, String?) -> Void) {
        networkService.homePageCall { result in
            switch result {
            case .success(let success):
                let manufacturer = success.make.name
                let model = success.model.name
                
                completion(manufacturer, model)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
//    func carDataFromVin(vin: String) {
//        networkService.homePageCall { result in
//            switch result {
//            case .success(let success):
//                let manufacturer = success.make.name
//                let model = success.model.name
////                let car = CarViewModel(manufacturer: manufacturer, milleage: 0, purchaseDate: "", vinNumber: "")
////                self.cars.append(car)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
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
