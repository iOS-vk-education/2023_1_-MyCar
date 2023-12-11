import Foundation

struct CarViewModel {
    
    var manufacturer: String
    var model: String
    var milleage: Int
    var purchaseDate: String
    var vinNumber: String
    
//    var works: [WorkModel] = []
    var works: [WorkModel]?
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
    
    struct Years: Codable {
        let id: Int
        let year: Int
        let styles: [Style]
    }

    struct Style: Codable {
        let id: Int
        let name: String
        let submodel: Submodel
        let trim: String
    }

    struct Submodel: Codable {
        let body: String
        let modelName: String
        let niceName: String
    }
    
    let make: Make
    let model: Model
    let years: [Years]

}


struct TO {
    let price: Int
    let date: String
}

struct CarMain {
    let info: CarViewModel
    let to: [TO]
}
