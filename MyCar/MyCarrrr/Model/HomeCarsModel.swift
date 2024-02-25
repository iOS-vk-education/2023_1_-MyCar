import Foundation
import UIKit

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = [] {
        didSet {
            print("saveCars")
            saveCars()
        }
    }
    
    
    init() {
        self.cars = loadCars()
    }
    
    func saveCars() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cars)
            
            
            UserDefaults.standard.set(data, forKey: "carsArrayKey")
            print("End saving")
        } catch {
            print("Ошибка при кодировании данных: \(error.localizedDescription)")
        }
    }
    
    func loadCars() -> [CarViewModel] {
        if let savedData = UserDefaults.standard.data(forKey: "carsArrayKey") {
            do {
                // Преобразуйте данные в массив структур
                let decoder = JSONDecoder()
                let loadedCarsArray = try decoder.decode([CarViewModel].self, from: savedData)

                // Теперь у вас есть загруженный массив структур
                print("Загруженный массив структур: \(loadedCarsArray.count)")
                return loadedCarsArray
            } catch {
                print("Ошибка при декодировании данных: \(error.localizedDescription)")
            }
        }
        print("Нет данных в UserDefaults для ключа 'carsArrayKey'")
        return []
        
    }
   
    
    func carDataFromVin(vin: String, completion: @escaping (String?, String?, Int?, Error?) -> Void) {
        let networkService = NetworkService(vin)

        networkService.homePageCall { result in
            switch result {
            case .success(let car):
                let manufacturer = car.make.name
                let model = car.model.name
                let year = car.years.first?.year
                completion(manufacturer, model, year, nil)
            case .failure(let failure):
                print(failure)
                completion(nil, nil, nil, failure)
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
        var updatedCar = cars[tag]
        updatedCar.manufacturer = car.manufacturer
        updatedCar.model = car.model
        updatedCar.vinNumber = car.vinNumber
        updatedCar.purchaseDate = car.purchaseDate
        updatedCar.milleage = car.milleage
        updatedCar.carImage = car.carImage
        
        cars[tag] = updatedCar
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
    
    func updateChequeImage(_ carIndex: Int, workIndex: Int, _ image: UIImage) {
        cars[carIndex].works[workIndex].workImage = image
    }
    
    func addWorkContent(_ carIndex: Int, workIndex: Int, _ text: String) {
        cars[carIndex].works[workIndex].content = text
    }
    
}
