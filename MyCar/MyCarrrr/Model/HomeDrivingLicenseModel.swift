//
//  HomeDrivingLicenseModel.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.03.2024.
//

import Foundation
import UIKit

final class HomeDrivingLicenseModel {
    
    private var drivingLicenses : DrivingLicenseModel? {
        didSet {
            print("save DrivingLicense")
            saveDrivingLicense()
        }
    }
    
    init() {
        self.drivingLicenses = loadDrivingLicense()
    }
    
    func saveDrivingLicense() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(drivingLicenses)
            
            
            UserDefaults.standard.set(data, forKey: "drivingLicensesArrayKey")
            print("End saving")
        } catch {
            print("Ошибка при кодировании данных: \(error.localizedDescription)")
        }
    }
    
    func loadDrivingLicense() -> DrivingLicenseModel? {
        if let savedData = UserDefaults.standard.data(forKey: "drivingLicensesArrayKey") {
            do {
                let decoder = JSONDecoder()
                let loadedDrivingLicenses = try decoder.decode(DrivingLicenseModel.self, from: savedData)
                
                return loadedDrivingLicenses
            } catch {
                print("Ошибка при декодировании данных: \(error.localizedDescription)")
            }
        }
        print("Нет данных в UserDefaults для ключа 'drivingLicensesArrayKey'")
        return nil
    }
    
    func remove() {
        drivingLicenses = nil
    }
    
    func drivingLicenseImage() -> UIImage? {
        drivingLicenses?.drivingLicenseImage
    }
    
    func addDrivingLicense (_ image: UIImage) {
        drivingLicenses = DrivingLicenseModel(drivingLicenseImage: image)
        print("add DL")
    }
    
    func changeDrivingLicenseImage (_ image: UIImage) {
        drivingLicenses?.drivingLicenseImage = image
        print("change DL")
    }
    
}
