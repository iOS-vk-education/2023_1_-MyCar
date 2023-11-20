import Foundation
import UIKit

class AddCarView: UIView {
    
    
    private let headerLabel = UILabel()
    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    private let addVINButton = UIButton()

    
    var carBrandTextField = UITextField()
    var carModelTextField = UITextField()
    var carYearTextField = UITextField()
    var carMileageTextField = UITextField()
    var carColorTextField = UITextField()
    var vinNumberTextField = UITextField()

    var updateButtonTappedHandler: (() -> Void)?
    var cancelButtonTappedHandler: (() -> Void)?
    var addVINButtonTappedHandler: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setupHeaderLabel("Автомобиль")
        setupContentField()
        setupButtons()
        setupAddVINButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAddVINButton() {
        self.addSubview(addVINButton)
        addVINButton.setTitle("+", for: .normal)
        addVINButton.backgroundColor = .black
        addVINButton.layer.cornerRadius = 30
        addVINButton.setTitleColor(.yellow, for: .normal)
        
        addVINButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addVINButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -85),
            addVINButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            addVINButton.widthAnchor.constraint(equalToConstant: 64),
            addVINButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        addVINButton.addTarget(self, action: #selector(didTapAddVINButton), for: .touchUpInside)
    }
    
    private func setupHeaderLabel( _ label: String) {
        self.addSubview(headerLabel)
        headerLabel.text = label
        headerLabel.textColor = .black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            headerLabel.widthAnchor.constraint(equalToConstant: 390),
            headerLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func setupContentField() {
        //Настройка label для текстовых полей
        let carBrandLabel = UILabel()
        configureTextLabel(carBrandLabel, text: "Введите марку:")
        
        let carModelLabel = UILabel()
        configureTextLabel(carModelLabel, text: "Модель:")

        let carYearLabel = UILabel()
        configureTextLabel(carYearLabel, text: "Год выпуска:")

        let carMileageLabel = UILabel()
        configureTextLabel(carMileageLabel, text: "Пробег:")

        let carColorLabel = UILabel()
        configureTextLabel(carColorLabel, text: "Цвет:")

        let vinNumberLabel = UILabel()
        configureTextLabel(vinNumberLabel, text: "ВИН номер:")

        
        carBrandTextField = UITextField()
        configureTextField(carBrandTextField, placeholder: "Enter car brand")
        
        carModelTextField = UITextField()
        configureTextField(carModelTextField, placeholder: "Enter car model")
        
        carYearTextField = UITextField()
        configureTextField(carYearTextField, placeholder: "Enter car year")
        
        carMileageTextField = UITextField()
        configureTextField(carMileageTextField, placeholder: "Enter car mileage")
        
        carColorTextField = UITextField()
        configureTextField(carColorTextField, placeholder: "Enter car color")
        
        vinNumberTextField = UITextField()
        configureTextField(vinNumberTextField, placeholder: "Enter VIN number")

        
        //добавление картинки
        let carImageView = UIImageView()
            carImageView.image = UIImage(named: "bmw5") // Укажите имя вашей картинки
            carImageView.contentMode = .scaleAspectFit
            carImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(carImageView)
        

        // Констрейнты для картинки
            carImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
            carImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            carImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true // Установите нужную высоту
            carImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true // Установите нужную ширину
        
        
        NSLayoutConstraint.activate([
            
            carBrandLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 20),
            carBrandLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carBrandTextField.centerYAnchor.constraint(equalTo: carBrandLabel.centerYAnchor),
            carBrandTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            carModelLabel.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: 20),
            carModelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carModelTextField.centerYAnchor.constraint(equalTo: carModelLabel.centerYAnchor),
            carModelTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            carYearLabel.topAnchor.constraint(equalTo: carModelLabel.bottomAnchor, constant: 20),
            carYearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carYearTextField.centerYAnchor.constraint(equalTo: carYearLabel.centerYAnchor),
            carYearTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            carMileageLabel.topAnchor.constraint(equalTo: carYearLabel.bottomAnchor, constant: 20),
            carMileageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carMileageTextField.centerYAnchor.constraint(equalTo: carMileageLabel.centerYAnchor),
            carMileageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            carColorLabel.topAnchor.constraint(equalTo: carMileageLabel.bottomAnchor, constant: 20),
            carColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carColorTextField.centerYAnchor.constraint(equalTo: carColorLabel.centerYAnchor),
            carColorTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            vinNumberLabel.topAnchor.constraint(equalTo: carColorLabel.bottomAnchor, constant: 20),
            vinNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vinNumberTextField.centerYAnchor.constraint(equalTo: vinNumberLabel.centerYAnchor),
            vinNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

    }
 
    
    private func configureTextLabel(_ textLabel: UILabel, text: String) {
        textLabel.text = text
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.text = ""
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.layer.borderWidth = 2.0
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        // Установка фиксированной ширины текстового поля
        let fixedWidth: CGFloat = 150
        textField.widthAnchor.constraint(equalToConstant: fixedWidth).isActive = true
        
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButtons() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        let updateButton = UIButton()
        updateButton.setTitle("Обновить", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .darkGray
        updateButton.layer.cornerRadius = 20
        
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.layer.cornerRadius = 20
        
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(updateButton)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])

        
        //TODO: Добавьте обработчики действий для кнопок
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
    }

    
//    var enteredCar: Car {
//        let brand = carBrandTextField.text ?? ""
//        let model = carModelTextField.text ?? ""
//        let year = Int(carYearTextField.text ?? "") ?? 0
//        let mileage = Int(carMileageTextField.text ?? "") ?? 0
//        let color = carColorTextField.text ?? ""
//        let vinNumber = vinNumberTextField.text ?? ""
//        
//        return Car(brand: brand, model: model, year: year, mileage: mileage, color: color, vinNumber: vinNumber)
//    }
    
    @objc
    private func updateButtonTapped() {
            // Вызываем замыкание при нажатии на кнопку "Обновить"
            updateButtonTappedHandler?()
        }
    
    @objc
    private func cancelButtonTapped() {
            // Вызываем замыкание при нажатии на кнопку "Обновить"
            cancelButtonTappedHandler?()
        }
    
    @objc func didTapAddVINButton() {
        addVINButtonTappedHandler?()
    }
    
    
}

