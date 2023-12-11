import Foundation

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = []
    
    
    func loadCars() {
        // user defaults get
    }
    
    func carDataFromVin(vin: String, completion: @escaping (String?, String?, Int?) -> Void) {
        let networkService = NetworkService(vin)

        networkService.homePageCall { result in
            switch result {
            case .success(let car):
                let manufacturer = car.make.name
                let model = car.model.name
                let year = car.years.first?.year
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
    
    func editCar(_ car: CarViewModel) {
        cars[0].manufacturer = car.manufacturer
        print("Car edit function!")
    }
    
    func updateMileage(_ carIndex: Int, mileage: Int){
        cars[carIndex].milleage = mileage
    }
    //MARK: fix
    func allWorks(_ car: inout CarViewModel) -> [WorkModel] {
         car.works ?? [WorkModel(date: "1", mileage: "100000", content: "content", price: "2000"), WorkModel(date: "2", mileage: "100000", content: "content2", price: "3000")]
    }
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel {
        cars[carIndex].works?[workIndex] ?? WorkModel(date: "3", mileage: "1000", content: "content", price: "40000")
    }
    
}
