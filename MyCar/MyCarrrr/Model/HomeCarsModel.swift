import Foundation
import UIKit
import CoreLocation

final class HomeCarsModel {
    
    private var cars : [CarViewModel] = [] {
        didSet {
            print("saveCars")
            saveCars(cars)
        }
    }
    
    
    let locationManager = LocationManager.shared
    
    init() {
        self.cars = loadCars()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func saveCars(_ cars: [CarViewModel]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(cars)
            let fileURL = getDocumentsDirectory().appendingPathComponent("cars.json")
            try data.write(to: fileURL)
            print("Данные успешно сохранены")
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
        }
    }

    func loadCars() -> [CarViewModel] {
        let fileURL = getDocumentsDirectory().appendingPathComponent("cars.json")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let loadedCars = try decoder.decode([CarViewModel].self, from: data)
                print("Загружено \(loadedCars.count) автомобилей")
                return loadedCars
            } catch {
                print("Ошибка при загрузке данных: \(error.localizedDescription)")
            }
        } else {
            print("Файл данных не найден")
        }
        return []
    }
    
//    func saveCars() {
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(cars)
//            
//            
//            UserDefaults.standard.set(data, forKey: "carsArrayKey")
//            print("End saving")
//        } catch {
//            print("Ошибка при кодировании данных: \(error.localizedDescription)")
//        }
//    }
//    
//    func loadCars() -> [CarViewModel] {
//        if let savedData = UserDefaults.standard.data(forKey: "carsArrayKey") {
//            do {
//                // Преобразуйте данные в массив структур
//                let decoder = JSONDecoder()
//                let loadedCarsArray = try decoder.decode([CarViewModel].self, from: savedData)
//
//                // Теперь у вас есть загруженный массив структур
//                print("Загруженный массив структур: \(loadedCarsArray.count)")
//                return loadedCarsArray
//            } catch {
//                print("Ошибка при декодировании данных: \(error.localizedDescription)")
//            }
//        }
//        print("Нет данных в UserDefaults для ключа 'carsArrayKey'")
//        return []
//    }
   
    
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
    
    func carForMap(index: Int) -> CarViewModel? {
        guard index >= 0, index < cars.count else {
            return nil
        }
        return cars[index]
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
    func updateStsImage(_ image: UIImage, _ tag: Int) {
        cars[tag].stsImage = image
    }
    
    func updateInsuranceDate(_ carIndex: Int, date: String) {
//        NotificationCenter.default.post(name: .insuranceDateUpdated, object: nil)
        NotificationCenter.default.post(name: .insuranceDateUpdated, object: nil, userInfo: ["carIndex": carIndex, "date": date])

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
    
    func setCarLocation(_ carIndex: Int) {
        locationManager.getLocation { location in
            // Обработка полученных координат
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
            self.cars[carIndex].carLocationLatitude = String(location.coordinate.latitude)
            self.cars[carIndex].carLocationLongitude = String(location.coordinate.longitude)
        }
        
    }
    
    func removeStsImage(_ carIndex: Int) {
        cars[carIndex].stsImage = nil
    }
    
    func removeInsureanceImage(_ carIndex: Int) {
        cars[carIndex].insurenceImage = nil
    }
    
}

extension Notification.Name {
    static let insuranceDateUpdated = Notification.Name("insuranceDateUpdated")
}
