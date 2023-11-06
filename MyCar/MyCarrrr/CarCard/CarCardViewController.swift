
import UIKit

protocol CarCardViewControllerDelegate: AnyObject {
    func goTo()
//    func enterVin()
}

class CarCardViewController: UIViewController {
    
    
    
    private var contentView: CarCardView{
        view as! CarCardView
    }
    
    override func loadView() {
        let car = Car(brand: "BMW", model: "5 series", year: 2022, mileage: 100_000, color: "Black", vinNumber: 1234567890)
        // Pass the Car instance to CarCardView
        view = CarCardView(car: car)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
    }
    
    private func goToAddCar() {
        let vc = EditCarViewController(car: contentView.car)
        present(vc, animated: true)
    }
    
    //TODO: убрать это в mycarVC
    private func callAlert() {
        let alert = UIAlertController(title: "Добавить новую машину", message: "Введите VIN автомобиля", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "VIN code"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [self] _ in
            guard let field = alert.textFields, field.count == 1 else {
                return
            }
            let vinCodeField = field[0]
            guard let vinCode = vinCodeField.text, !vinCode.isEmpty && vinCode.count == 17 else{
                let errorAlert = UIAlertController(title: "Ошибка", message: "Некорректный VIN код", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(errorAlert, animated: true)
                return
            }
            let api = Api(vin: vinCode)
            let names = api.getBrandAndModel()
            print(names)
            self.goTo()
        }))
        present(alert, animated: true)
    }
    

}

extension CarCardViewController: CarCardViewControllerDelegate {
    func goTo() {
        goToAddCar()
    }
    
//    func enterVin() {
//        callAlert()
//    }
}
