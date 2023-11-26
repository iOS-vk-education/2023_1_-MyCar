import Foundation
import UIKit

class AddCarView: UIView {
    
    
    private let headerLabel = UILabel()
    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    
    let checkVINButton = UIButton()
    
    let carBrandLabel = UILabel()
    let carModelLabel = UILabel()
    let carYearLabel = UILabel()
    let carMileageLabel = UILabel()
    let vinNumberLabel = UILabel()
    
    var carBrandTextField = UITextField()
    var carModelTextField = UITextField()
    var carYearTextField = UITextField()
    var carMileageTextField = UITextField()
    var vinNumberTextField = UITextField()
    
    var updateButtonTappedHandler: (() -> Void)?
    var cancelButtonTappedHandler: (() -> Void)?
    
    var checkVINButtonTappedHandler: (() -> Void)?
    var checkVINCompletion: (() -> Void)?
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setupHeaderLabel("Автомобиль")
        setupContentField()
        setupButtons()
        setupCheckButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        configureTextLabel(carBrandLabel, text: "Введите марку:")
        configureTextLabel(carModelLabel, text: "Модель:")
        configureTextLabel(carYearLabel, text: "Год выпуска:")
        configureTextLabel(carMileageLabel, text: "Пробег:")
        configureTextLabel(vinNumberLabel, text: "ВИН номер:")
        
        
        
        configureTextField(carBrandTextField, placeholder: "Enter car brand")
        configureTextField(carModelTextField, placeholder: "Enter car model")
        configureTextField(carYearTextField, placeholder: "Enter car year")
        configureTextField(carMileageTextField, placeholder: "Enter car mileage")
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
            
            vinNumberLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 20),
            vinNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vinNumberTextField.centerYAnchor.constraint(equalTo: vinNumberLabel.centerYAnchor),
            vinNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            carBrandLabel.topAnchor.constraint(equalTo: vinNumberLabel.bottomAnchor, constant: 80),
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
            carMileageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
            
            
            
        ])
        
        
        
        
    }
    
    private func setupCheckButton() {
        self.addSubview(checkVINButton)
        checkVINButton.setTitle("Заполнить по VIN", for: .normal)
        checkVINButton.setTitleColor(.white, for: .normal)
        checkVINButton.backgroundColor = .darkGray
        checkVINButton.layer.cornerRadius = 10
        
        checkVINButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            checkVINButton.topAnchor.constraint(equalTo: vinNumberLabel.bottomAnchor, constant: 20),
            checkVINButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            checkVINButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        // Создаем активити индикатор
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        
        checkVINButton.addSubview(activityIndicator)
        
        // Устанавливаем ограничения для активити индикатора
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: checkVINButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: checkVINButton.centerYAnchor),
        ])
        
        // Делаем активити индикатор начально невидимым
        activityIndicator.stopAnimating()
        
        // Добавляем обработчик нажатия на кнопку
        checkVINButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
    }
  
    
    
    private func configureTextLabel(_ textLabel: UILabel, text: String) {
        textLabel.text = text
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.clearButtonMode = .always
        textField.text = ""
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.layer.borderWidth = 2.0
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        // Установка фиксированной ширины текстового поля
        let fixedWidth: CGFloat = 225
        textField.widthAnchor.constraint(equalToConstant: fixedWidth).isActive = true

        
        let fixedHeight: CGFloat = 30
        textField.heightAnchor.constraint(equalToConstant: fixedHeight).isActive = true
        
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
        
        
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc private func checkButtonTapped() {
        // Включаем активити индикатор и блокируем кнопку
        checkVINButton.isEnabled = false
        checkVINButton.setTitle("", for: .normal)
        (checkVINButton.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView)?.startAnimating()
        
        checkVINButtonTappedHandler?()
        checkVINCompletion?()
        
    }
    
    
    @objc
    private func updateButtonTapped() {
        // Вызываем замыкание при нажатии на кнопку "Обновить"
        updateButtonTappedHandler?()
    }
    
    @objc
    private func cancelButtonTapped() {
        // Вызываем замыкание при нажатии на кнопку "Отмена"
        cancelButtonTappedHandler?()
    }
    
}

