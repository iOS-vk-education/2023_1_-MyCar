import UIKit



class AddCarViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = AddCarView()
    
    let imagePicker = UIImagePickerController()
    private var image = UIImage(named: "jeep")
    
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
        contentView.imageButtonTappedHandler = { [weak self] in
            self?.changeImage()
        }
        
        imagePicker.delegate = self
        
        contentView.carBrandTextField.delegate = self
        contentView.carModelTextField.delegate = self
        contentView.carMileageTextField.delegate = self
        contentView.carYearTextField.delegate = self
        contentView.vinNumberTextField.delegate = self
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        contentView.scrollView.isScrollEnabled = true
        contentView.scrollView.contentOffset = CGPoint(x: 0, y: 200)
        contentView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        contentView.scrollView.isScrollEnabled = false
        contentView.scrollView.contentOffset = CGPoint.zero
    }
    
    private func changeImage() {
        // вызов метода определяющего тип выбора изображения (camera / photo library)
        let actionSheet = UIAlertController(title: nil, message: "Выберите изображение", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func photoLibrary() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func cancelAdd() {
        dismiss(animated: true)
    }
    
    private func saveCar() {
        if (contentView.carBrandTextField.text == "" ||  contentView.carModelTextField.text == "") {
            let errorAlert = UIAlertController(title: "Ошибка", message: "Поля марка и модель не могут быть пустыми", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(errorAlert, animated: true)

            return
        }
        model.addCar(CarViewModel(manufacturer: contentView.carBrandTextField.text ?? "",
                                  model: contentView.carModelTextField.text ?? "",
                                  milleage: Int(contentView.carMileageTextField.text ?? "") ?? 0,
                                  purchaseDate: contentView.carYearTextField.text ?? "",
                                  vinNumber: contentView.vinNumberTextField.text ?? "",
                                  carImage: image
                                 ))
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
                self.contentView.checkVINButton.setTitle("Заполнить по VIN", for: .normal)
                (self.contentView.checkVINButton.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView)?.stopAnimating()
            }
            self.contentView.checkVINCompletion?()
            present(errorAlert, animated: true)
            return
        }
        
        model.carDataFromVin(vin: vinNumber) { manufacturer, model, year in
            DispatchQueue.main.async {
                self.contentView.checkVINButton.isEnabled = true
                self.contentView.checkVINButton.setTitle("Заполнить по VIN", for: .normal)
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
    
    deinit {
            // Unregister keyboard notifications when the view controller is deallocated
            NotificationCenter.default.removeObserver(self)
        }
    

}
extension AddCarViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            image = selectedImage
            contentView.updateImage(selectedImage)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension AddCarViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрыть клавиатуру при нажатии на Return
        textField.resignFirstResponder()
        return true
    }
}

