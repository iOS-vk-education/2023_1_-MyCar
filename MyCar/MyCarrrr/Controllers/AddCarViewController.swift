import UIKit



class AddCarViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = AddCarView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateButtonTappedHandler = { [weak self] in
            self?.saveCar()
        }
        contentView.cancelButtonTappedHandler = { [weak self] in
            self?.cancelAdd()
        }
        contentView.addVINButtonTappedHandler = { [weak self] in
            self?.callAlert()
        }

    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cancelAdd() {
        dismiss(animated: true)
    }
    
    private func saveCar() {
        
        model.addCar(CarViewModel(manufacturer: contentView.carBrandTextField.text ?? "",
                                  model: contentView.carModelTextField.text ?? "",
                                  milleage: Int(contentView.carMileageTextField.text ?? "") ?? 0,
                                  purchaseDate: "",
                                  vinNumber: contentView.vinNumberTextField.text ?? ""))
        // Отправка уведомления о том, что данные были обновлены
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
        print(model.allCars())
        // Закрытие AddCarViewController
        dismiss(animated: true)
    }
    
    private func enterFieldCarFromVIN(_ manufacturer: String, _ model: String) {
        DispatchQueue.main.async {
            self.contentView.carBrandTextField.text = manufacturer
            self.contentView.carModelTextField.text = model
            }
        print(#function)
    }
    
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

            model.carDataFromVin(vin: vinCode) { manufacturer, model in
                if let manufacturer = manufacturer, let model = model {
                    print("Manufacturer: \(manufacturer), Model: \(model)")
                    self.enterFieldCarFromVIN(manufacturer, model)
                } else {
                    print("Failed to fetch car data.")
                }
            }
            
            

        }))
        present(alert, animated: true)
    }

}


