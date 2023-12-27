//
//  WorkModel.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 06.12.2023.
//

import Foundation
import UIKit

struct WorkModel: Codable {
    var date: String
    var mileage: String
    var content: String
    var price: String
    
    var workImage: UIImage?
}

