//
//  UserDafaultsService.swift
//  MyCarrrr
//
//  Created by Anton Sharin on 13.11.2023.
//

import Foundation

final class UserDafaultsService {
    
    private let defaults = UserDefaults.standard
    
    func data(for key: String) -> Data {
        let someData = defaults.object(forKey: key)
        //return someData
        return Data()
    }
}
