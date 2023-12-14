//
//  WorkEditView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 14.12.2023.
//

import Foundation
import UIKit


class WorkEditView: UIView {
    
    weak var delegate: MileageViewDelegate?
    
    private var car: CarViewModel
    
    private let label: String
    private let carLabel = UILabel()
    private let updateLabel = UILabel()
    
    private let mileageLabel = UILabel()
    private let mileageTextField = UITextField()
    private let updateButton = UIButton(type: .system)
    
    private let measurementSegmentedControl = UISegmentedControl(items: ["Км", "Мили"])
    
    
    
    init(car: CarViewModel, label: String) {
        self.car = car
        self.label = label
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        
        setupHeaderLabel()
        setupCarLabel(label)
        setupMileageTextField()
//        setupMeasurementSegmentedControl()
        setupUpdateButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupHeaderLabel() {
        self.addSubview(carLabel)
        carLabel.text = car.manufacturer
//        carLabel.text = label
        carLabel.textColor = .white
        carLabel.font = UIFont.boldSystemFont(ofSize: 22)
        carLabel.textAlignment = .center
        
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 21),
            carLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
    
    private func setupCarLabel( _ label: String) {
        self.addSubview(updateLabel)
        updateLabel.text = label
        updateLabel.textColor = .white
        updateLabel.font = .systemFont(ofSize: 18)
        updateLabel.textAlignment = .center
        
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateLabel.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 0),
            updateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
    
    private func setupMileageTextField() {
    
        mileageTextField.textColor = .black
        mileageTextField.clearButtonMode = .always
        mileageTextField.text = ""
        mileageTextField.placeholder = "Введите новое значение"
        mileageTextField.textAlignment = .center
        mileageTextField.layer.borderWidth = 2.0
        mileageTextField.backgroundColor = .white
        mileageTextField.layer.cornerRadius = 9
        // Установка фиксированной ширины текстового поля
//        let fixedWidth: CGFloat = 210
//        mileageTextField.widthAnchor.constraint(equalToConstant: fixedWidth).isActive = true
        
        
        let fixedHeight: CGFloat = 40
        mileageTextField.heightAnchor.constraint(equalToConstant: fixedHeight).isActive = true
        
        self.addSubview(mileageTextField)
        
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mileageTextField.topAnchor.constraint(equalTo: updateLabel.bottomAnchor, constant: 21),
            
            mileageTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 21),
            mileageTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -21),
            
        ])
    }
    
    
   
    
    private func setupUpdateButton () {
        
        self.addSubview(updateButton)

        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        
        updateButton.setTitle("Обновить", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .black
        updateButton.layer.cornerRadius = 15
        
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: mileageTextField.bottomAnchor, constant: 21),
            updateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 351),
            updateButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    @objc private func didTapUpdateButton () {
        let mileage = Int(mileageTextField.text ?? "") ?? 0
        delegate?.didTapMileageButton(mileage)
    }
    
}




