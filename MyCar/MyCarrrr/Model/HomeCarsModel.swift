import Foundation
import UIKit

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
    
    func removeWork(at index: Int, carTag: Int){
        cars[carTag].works.remove(at: index)
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
    
    func editCar(_ car: CarViewModel, _ tag: Int) {
        cars[tag].manufacturer = car.manufacturer
        cars[tag].model = car.model
        cars[tag].vinNumber = car.vinNumber
        cars[tag].purchaseDate = car.purchaseDate
        cars[tag].milleage = car.milleage
        cars[tag].carImage = car.carImage
        print("Car edit function!")
    }
    
    func updateMileage(_ carIndex: Int, mileage: Int){
        cars[carIndex].milleage = mileage
    }
    
    func updateTOMileage(_ carIndex: Int, workIndex: Int, _ mileage: Int) {
        cars[carIndex].works[workIndex].mileage = String(mileage)
    }
    
    func updateTOPrice(_ carIndex: Int, workIndex: Int, _ price: Int) {
        cars[carIndex].works[workIndex].price = String(price)
    }
    
    func updateTODate(_ carIndex: Int, workIndex: Int, _ date: String) {
        cars[carIndex].works[workIndex].date = date
    }
    
    func updateNextTODate(_ carIndex: Int, _ date: String) {
        cars[carIndex].nextTODate = date
    }
    
    func addWork(_ work: WorkModel, _ tag: Int) {
        cars[tag].works.append(work)
    }
    
    func allWorks(_ carIndex: Int) -> [WorkModel] {
        cars[carIndex].works
    }
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel {
        cars[carIndex].works[workIndex]
    }
    
    
    func updateInsuranceImage(_ image: UIImage, _ tag: Int) {
        cars[tag].insurenceImage = image
    }
    
    func updateInsureanceDate(_ carIndex: Int, date: String){
        cars[carIndex].insurenceDate = date
    }
    
    func updateCarImage(_ image: UIImage, _ tag: Int){
        cars[tag].carImage = image
    }
    
//    func updateChequeImage(_ image: UIImage, _ tag: Int) {
//        cars[tag].insurenceImage = image
//    }
    func updateChequeImage(_ carIndex: Int, workIndex: Int, _ image: UIImage) {
        cars[carIndex].works[workIndex].workImage = image
    }
    
}
