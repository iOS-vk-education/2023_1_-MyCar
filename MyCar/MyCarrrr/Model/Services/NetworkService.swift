//
//  NetworkService.swift
//  MyCarrrr
//
//  Created by Anton Sharin on 13.11.2023.
//

import Foundation

final class NetworkService {
    
    let url = URL(string: "")
    
    func homePageCall(completion: @escaping (Result<CarViewModel,Error>)-> Void)  {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CarViewModel.self, from: data)
                completion(.success(decoded))
                
            }
            catch {
                completion(.failure(error))
            }
        }
            task.resume()
            
        }
}
