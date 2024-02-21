//
//  EditCarView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 09.12.2023.
//

import Foundation
import UIKit

protocol EditCarViewDelegate: AnyObject {
    func fillField() -> CarViewModel
}

class EditCarView: UIView{
    
    weak var delegate: EditCarViewDelegate?
    
    private let headerLabel = UILabel()
    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    let carImageView = UIImageView()
    
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
    var imageButtonTappedHandler: (() -> Void)?
    
    var checkVINButtonTappedHandler: (() -> Void)?
    var checkVINCompletion: (() -> Void)?
    
    let scrollView = UIScrollView()
    
    init() {
        super.init(frame: .zero)
//        self.backgroundColor = .black
        self.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        setupScrollView()
        setupHeaderLabel("Автомобиль")
        setupContentField()
        setupButtons()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
        }
    
    var carViewModel: CarViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let car = carViewModel else { return }
        
        carBrandTextField.text = car.manufacturer
        carModelTextField.text = car.model
        carYearTextField.text = car.purchaseDate
        carMileageTextField.text = "\(car.milleage)"
        vinNumberTextField.text = car.vinNumber
        
        carImageView.image = car.carImage
        
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the UIScrollView to cover the entire view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        scrollView.contentSize = CGSize(width: self.frame.width, height: 1000) // Adjust the height accordingly
        scrollView.isScrollEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        scrollView.addGestureRecognizer(tapGesture)
        scrollView.isUserInteractionEnabled = true

    }
    
    private func setupHeaderLabel( _ label: String) {
//        self.addSubview(headerLabel)
        scrollView.addSubview(headerLabel)

        headerLabel.text = label
        headerLabel.textColor = .white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 45),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            headerLabel.widthAnchor.constraint(equalToConstant: 390),
            headerLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    
    private func setupContentField() {
        //Настройка label для текстовых полей
        
        configureTextLabel(carBrandLabel, text: "Марка:")
        configureTextLabel(carModelLabel, text: "Модель:")
        configureTextLabel(carYearLabel, text: "Год выпуска:")
        configureTextLabel(carMileageLabel, text: "Пробег:")
        configureTextLabel(vinNumberLabel, text: "ВИН номер:")
        
        configureTextField(carBrandTextField, placeholder: "Введите марку авто")
        configureTextField(carModelTextField, placeholder: "Введите модель авто")
        configureTextField(carYearTextField, placeholder: "Введите год выпуска")
        configureTextField(carMileageTextField, placeholder: "Введите пробег авто")
        configureTextField(vinNumberTextField, placeholder: "Введите VIN номер")
        
        //добавление картинки
        
        carImageView.image = UIImage(named: "jeep") // Укажите имя вашей картинки
        carImageView.contentMode = .scaleAspectFit
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(carImageView)

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        carImageView.addGestureRecognizer(tapGesture)
        carImageView.isUserInteractionEnabled = true
        
        
        // Констрейнты для картинки
        carImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        carImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true // Установите нужную высоту
        carImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true // Установите нужную ширину
        
        
        NSLayoutConstraint.activate([
            
            vinNumberLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 20),
            vinNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            vinNumberTextField.topAnchor.constraint(equalTo: vinNumberLabel.bottomAnchor, constant: 0),
            vinNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            
            carBrandLabel.topAnchor.constraint(equalTo: vinNumberTextField.bottomAnchor, constant: 21),
            carBrandLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            carBrandTextField.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: 0),
            carBrandTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            
            carModelLabel.topAnchor.constraint(equalTo: carBrandTextField.bottomAnchor, constant: 21),
            carModelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            carModelTextField.topAnchor.constraint(equalTo: carModelLabel.bottomAnchor, constant: 0),
            carModelTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            
            carYearLabel.topAnchor.constraint(equalTo: carModelTextField.bottomAnchor, constant: 21),
            carYearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            carYearTextField.topAnchor.constraint(equalTo: carYearLabel.bottomAnchor, constant: 0),
            carYearTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            
            carMileageLabel.topAnchor.constraint(equalTo: carYearTextField.bottomAnchor, constant: 21),
            carMileageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            carMileageTextField.topAnchor.constraint(equalTo: carMileageLabel.bottomAnchor, constant: 0),
            carMileageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            
        ])
        
    }
    
    private func configureTextLabel(_ textLabel: UILabel, text: String) {
        textLabel.textColor = .white
        textLabel.text = text
        scrollView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 20)
        textField.clearButtonMode = .always
        textField.text = ""
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.textAlignment = .left
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 5
        // Установка фиксированной ширины текстового поля
        let fixedWidth: CGFloat = 350
        textField.widthAnchor.constraint(equalToConstant: fixedWidth).isActive = true
        
        let fixedHeight: CGFloat = 30
        textField.heightAnchor.constraint(equalToConstant: fixedHeight).isActive = true
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 30, width: 350, height: 1))
        separatorView.backgroundColor = .white
        textField.addSubview(separatorView)
        

        scrollView.addSubview(textField)

        
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButtons() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        let updateButton = UIButton(type: .system)
        updateButton.setTitle("Обновить", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .black
        updateButton.layer.cornerRadius = 15
        
        
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.layer.cornerRadius = 15
        
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(updateButton)
        

        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
    }
    
    func updateImage(_ image: UIImage) {
        carImageView.image = image
    }
    
    @objc
    private func didTapScreen() {
        carBrandTextField.resignFirstResponder()
        carModelTextField.resignFirstResponder()
        carYearTextField.resignFirstResponder()
        carMileageTextField.resignFirstResponder()
        vinNumberTextField.resignFirstResponder()
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
    
    @objc
    private func didTapImage() {
        imageButtonTappedHandler?()
    }
    
}




