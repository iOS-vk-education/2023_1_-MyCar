import Foundation
import UIKit

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = []
    
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
                // 2. Преобразуйте данные в массив структур
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
        saveCars()
    }
    
    func removeWork(at index: Int, carTag: Int){
        cars[carTag].works.remove(at: index)
        saveCars()
    }
    
    func car(index: Int) -> CarViewModel {
        cars[index]
    }
    
    func addCar(_ car: CarViewModel) {
        cars.append(car)
        saveCars()
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
        saveCars()
    }
    
    func updateMileage(_ carIndex: Int, mileage: Int){
        cars[carIndex].milleage = mileage
        saveCars()
    }
    
    func updateTOMileage(_ carIndex: Int, workIndex: Int, _ mileage: Int) {
        cars[carIndex].works[workIndex].mileage = String(mileage)
        saveCars()
    }
    
    func updateTOPrice(_ carIndex: Int, workIndex: Int, _ price: Int) {
        cars[carIndex].works[workIndex].price = String(price)
        saveCars()
    }
    
    func updateTODate(_ carIndex: Int, workIndex: Int, _ date: String) {
        cars[carIndex].works[workIndex].date = date
        saveCars()
    }
    
    func updateNextTODate(_ carIndex: Int, _ date: String) {
        cars[carIndex].nextTODate = date
        saveCars()
    }
    
    func addWork(_ work: WorkModel, _ tag: Int) {
        cars[tag].works.append(work)
        saveCars()
    }
    
    func allWorks(_ carIndex: Int) -> [WorkModel] {
        cars[carIndex].works
    }
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel {
        cars[carIndex].works[workIndex]
    }
    
    
    func updateInsuranceImage(_ image: UIImage, _ tag: Int) {
        cars[tag].insurenceImage = image
        saveCars()
    }
    
    func updateInsureanceDate(_ carIndex: Int, date: String){
        cars[carIndex].insurenceDate = date
        saveCars()
    }
    
    func updateCarImage(_ image: UIImage, _ tag: Int){
        cars[tag].carImage = image
        saveCars()
    }
    
//    func updateChequeImage(_ image: UIImage, _ tag: Int) {
//        cars[tag].insurenceImage = image
//    }
    func updateChequeImage(_ carIndex: Int, workIndex: Int, _ image: UIImage) {
        cars[carIndex].works[workIndex].workImage = image
        saveCars()
    }
    
    func addWorkContent(_ carIndex: Int, workIndex: Int, _ text: String) {
        cars[carIndex].works[workIndex].content = text
        saveCars()
    }
    
}
