import UIKit


//func getDocumentsDirectory() -> URL {
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    return paths[0]
//}
//
//func saveCars2(_ cars: [CarViewModel]) {
//    let encoder = JSONEncoder()
//    do {
//        let data = try encoder.encode(cars)
//        let fileURL = getDocumentsDirectory().appendingPathComponent("cars.json")
//        try data.write(to: fileURL)
//        print("Данные успешно сохранены")
//    } catch {
//        print("Ошибка при сохранении данных: \(error.localizedDescription)")
//    }
//}
//
//func loadCars2() -> [CarViewModel] {
//    let fileURL = getDocumentsDirectory().appendingPathComponent("cars.json")
//    if FileManager.default.fileExists(atPath: fileURL.path) {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let loadedCars = try decoder.decode([CarViewModel].self, from: data)
//            print("Загружено \(loadedCars.count) автомобилей")
//            return loadedCars
//        } catch {
//            print("Ошибка при загрузке данных: \(error.localizedDescription)")
//        }
//    } else {
//        print("Файл данных не найден")
//    }
//    return []
//}
