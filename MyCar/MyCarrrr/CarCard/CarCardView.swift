//
//  CarCardView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 01.11.2023.
//

import Foundation
import UIKit

class CarCardView: UIView {
    
    weak var delegate: CarCardViewControllerDelegate?
    
    private let headerLabel = UILabel()
    private let editCarButton = UIButton()
    
    
    var car: Car
    
    
    
    init(car: Car) {
        self.car = car
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setupHeaderLabel("Автомобиль")
        setupContentField(car)
        setupAddCarButton()
        
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
    
    private func setupAddCarButton() {
        self.addSubview(editCarButton)
        editCarButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editCarButton.backgroundColor = .black
        editCarButton.layer.cornerRadius = 30
        
        editCarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editCarButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -85),
            editCarButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            editCarButton.widthAnchor.constraint(equalToConstant: 64),
            editCarButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        editCarButton.addTarget(self, action: #selector(editCarButtonTapped), for: .touchUpInside)
    }
    
    @objc func editCarButtonTapped() {
        delegate?.goTo()
//        delegate?.enterVin()
    }
    
    
    


    
    //TODO: заглушка
    private func isValidVin(_ vin: String) -> Bool {
        return true
    }
    
    private func setupContentField(_ car: Car) {
        
//        let api = Api(vin: "WBAGG83461DN81194")
//        let names = api.getBrandAndModel()
//
//        car.brand = names[0]
//        car.model = names[1]
        
        //Настройка label для текстовых полей
        let carBrandLabel = UILabel()
        configureTextLabel(carBrandLabel, text: "Марка:")
        
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
        
        
        let carBrandTextField = UITextField()
        let carModelTextField = UITextField()
        let carYearTextField = UITextField()
        let carMileageTextField = UITextField()
        let carColorTextField = UITextField()
        let vinNumberTextField = UITextField()
        //Настройка текстовых полей из модели
        configureTextField(carBrandTextField, text: car.brand)
        configureTextField(carModelTextField, text: car.model)
        configureTextField(carYearTextField, text: String(car.year))
        configureTextField(carMileageTextField, text: String(car.mileage))
        configureTextField(carColorTextField, text: car.color)
        configureTextField(vinNumberTextField, text: String(car.vinNumber))
        
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
            carBrandTextField.centerYAnchor.constraint(equalTo: carBrandLabel.centerYAnchor), // Центрирование текстового поля по вертикали
            carBrandTextField.leadingAnchor.constraint(equalTo: carBrandLabel.trailingAnchor, constant: 8), // Отступ текстового поля от метки

            
            carModelLabel.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: 20),
            carModelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carModelTextField.centerYAnchor.constraint(equalTo: carModelLabel.centerYAnchor),
            carModelTextField.leadingAnchor.constraint(equalTo: carModelLabel.trailingAnchor, constant: 8),
            
            carYearLabel.topAnchor.constraint(equalTo: carModelLabel.bottomAnchor, constant: 20),
            carYearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carYearTextField.centerYAnchor.constraint(equalTo: carYearLabel.centerYAnchor),
            carYearTextField.leadingAnchor.constraint(equalTo: carYearLabel.trailingAnchor, constant: 8),
            
            carMileageLabel.topAnchor.constraint(equalTo: carYearLabel.bottomAnchor, constant: 20),
            carMileageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carMileageTextField.centerYAnchor.constraint(equalTo: carMileageLabel.centerYAnchor),
            carMileageTextField.leadingAnchor.constraint(equalTo: carMileageLabel.trailingAnchor, constant: 8),
            
            carColorLabel.topAnchor.constraint(equalTo: carMileageLabel.bottomAnchor, constant: 20),
            carColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carColorTextField.centerYAnchor.constraint(equalTo: carColorLabel.centerYAnchor),
            carColorTextField.leadingAnchor.constraint(equalTo: carColorLabel.trailingAnchor, constant: 8),
            
            vinNumberLabel.topAnchor.constraint(equalTo: carColorLabel.bottomAnchor, constant: 20),
            vinNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            vinNumberTextField.centerYAnchor.constraint(equalTo: vinNumberLabel.centerYAnchor),
            vinNumberTextField.leadingAnchor.constraint(equalTo: vinNumberLabel.trailingAnchor, constant: 8)
            
        ])

    }
    
    private func configureTextLabel(_ textLabel: UILabel, text: String) {
        textLabel.text = text
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextField(_ textField: UITextField, text: String) {
        textField.text = text
        textField.isUserInteractionEnabled = false
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    

    
}
