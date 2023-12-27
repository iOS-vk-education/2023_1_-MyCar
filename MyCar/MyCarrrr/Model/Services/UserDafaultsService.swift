import Foundation

final class UserDafaultsService {
    
    private let defaults = UserDefaults.standard
    
    func data(for key: String) -> Data {
        let someData = defaults.object(forKey: key)
        
        return Data()
    }
    
}
