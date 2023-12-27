//
//  TODateView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 14.12.2023.
//

import Foundation
import UIKit


protocol DateViewDelegate: AnyObject {
    func didTapDateButton(_ date: String)
}


class TODateView: UIView {
    
    weak var delegate: DateViewDelegate?
    
    private var car: CarViewModel
    
    private let label: String
    private let carLabel = UILabel()
    
    private let mileageLabel = UILabel()

    private let datePicker = UIDatePicker()

    private let updateButton = UIButton(type: .system)
    
    
    
    
    
    init(car: CarViewModel, label: String) {
        self.car = car
        self.label = label
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        
        setupHeaderLabel()
        
        setupDatePicker()
        setupUpdateButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupHeaderLabel() {
        self.addSubview(carLabel)
        carLabel.text = label
        carLabel.textColor = .white
        carLabel.font = UIFont.boldSystemFont(ofSize: 22)
        carLabel.textAlignment = .center
        
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 21),
            carLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
    
   
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .white
        datePicker.setValue(UIColor.white, forKey: "textColor")

        
        self.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 21),
            datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 21),
            datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -21)
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
            updateButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 21),
            updateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 351),
            updateButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    @objc private func didTapUpdateButton () {
//        let mileage = Int(mileageTextField.text ?? "") ?? 0
//        delegate?.didTapMileageButton(mileage)
        let currentDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        delegate?.didTapDateButton(dateString)
        
    }
    
}




