import Foundation

struct CarViewModel: Codable {
    
    let manufacturer: String
    let model: String
    let milleage: Int
    let purchaseDate: String
    let vinNumber: String
    
}

struct CarInfo: Codable {
    
    struct Make: Codable {
        let id: Int
        let name: String
        let niceName: String
    }

    struct Model: Codable {
        let id: String
        let name: String
        let niceName: String
    }

    let make: Make
    let model: Model
}


struct TO {
    let price: Int
    let date: String
}

struct CarMain {
    let info: CarViewModel
    let to: [TO]
}
