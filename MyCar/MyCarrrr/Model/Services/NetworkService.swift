import Foundation

final class NetworkService {
    
    var vin : String
    let url : URL
    
//    let vinChevi = "1G1AF1F57A7192174"
//    let vinBmw = "WBAGG83461DN81194"
//    let vinTesla = "5YJSA1E62NF016329"
    
    init() {
        self.vin = "WBAGG83461DN81194"
        self.url = URL(string: "https://auto.dev/api/vin/\(vin)?apikey=ZrQEPSkKc2VyZ2V5LnZhc2lsaWV3MjAxNkBnbWFpbC5jb20=")!
    }
    
    
    
    func homePageCall(completion: @escaping (Result<CarInfo,Error>)-> Void)  {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CarInfo.self, from: data)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(error))
            }
        }
            task.resume()
            
        }
}
