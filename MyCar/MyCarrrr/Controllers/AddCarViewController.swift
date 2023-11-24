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
        contentView.checkVINButtonTappedHandler = { [weak self] in
            self?.checkVIN()
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
    
    private func enterFieldCarFromVIN(_ manufacturer: String, _ model: String, _ year: Int) {
        DispatchQueue.main.async {
            self.contentView.carBrandTextField.text = manufacturer
            self.contentView.carModelTextField.text = model
            self.contentView.carYearTextField.text = String(year)
            }
        print(#function)
    }
    
    
    private func checkVIN() {
        
        guard let vinNumber = contentView.vinNumberTextField.text, !vinNumber.isEmpty && vinNumber.count == 17 else{
            let errorAlert = UIAlertController(title: "Ошибка", message: "Некорректный VIN код", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            DispatchQueue.main.async {
                self.contentView.checkVINButton.isEnabled = true
                self.contentView.checkVINButton.setTitle("Check", for: .normal)
                (self.contentView.checkVINButton.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView)?.stopAnimating()
            }
            self.contentView.checkVINCompletion?()
            present(errorAlert, animated: true)
            return
        }
        
        model.carDataFromVin(vin: vinNumber) { manufacturer, model, year in
            DispatchQueue.main.async {
                self.contentView.checkVINButton.isEnabled = true
                self.contentView.checkVINButton.setTitle("Check", for: .normal)
                (self.contentView.checkVINButton.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView)?.stopAnimating()
            }
            if let manufacturer = manufacturer, let model = model, let year = year{
                print("Manufacturer: \(manufacturer), Model: \(model), year: \(year)")
                self.enterFieldCarFromVIN(manufacturer, model, year)
            } else {
                print("Failed to fetch car data.")
            }
        }
        
        // Call the completion handler in AddCarView
        self.contentView.checkVINCompletion?()
        
    }
    

}


