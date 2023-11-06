import Foundation

class Api {
    var vin: String

    init(vin: String) {
        self.vin = vin
    }
    
    func getBrandAndModel () -> [String] {
        let text = getRequest()
        let words = text.components(separatedBy: "_")
        return words
    }

    func getRequest() -> String {
        let vin = self.vin
        let vinChevi = "1G1AF1F57A7192174"
        let vinBmw = "WBAGG83461DN81194"
        let vinTesla = "5YJSA1E62NF016329"
        // Замените URL на фактический URL вашего API, используя VIN-номер
        let apiUrlString = "https://auto.dev/api/vin/\(vin)?apikey=ZrQEPSkKc2VyZ2V5LnZhc2lsaWV3MjAxNkBnbWFpbC5jb20="

        if let url = URL(string: apiUrlString) {
            var resultString = "" // Создаем переменную для результата
            let semaphore = DispatchSemaphore(value: 0) // Создаем семафор

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                defer {
                    semaphore.signal() // Сигнализируем семафору, что запрос завершился
                }

                if let error = error {
                    print("Ошибка при выполнении запроса: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        print("Ошибка с ответом, непредвиденный статус код: \(response)")
                        return
                }

                if let data = data {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            resultString = self.decodeJsonObj(data: jsonObject)
                        }
                    } catch {
                        print("Ошибка при десериализации JSON: \(error)")
                    }
                }
            }
            task.resume()

            semaphore.wait() // Ожидаем завершения запроса
//            return resultString
            return resultString
        } else {
            print("Ошибка: неверный URL")
            return "Invalid URL"
        }
    }

    func decodeJsonObj(data: [String: Any]) -> String {
        
        var brand = ""
        var model = ""

        guard let makeField = data["make"] as? [String: Any] else {
            return "Error in decode brand"
        }
        
        if let brandName = makeField["name"] as? String {
            brand = brandName
        } else {
            return "Brand not found"
        }
        
        guard let modelField = data["model"] as? [String: Any] else {
            return "Error in decode model"
        }
        
        if let modelName = modelField["name"] as? String {
            model = modelName
        } else {
            return "Model not found"
        }
        
        return brand + "_" + model
    }
    
    
}
