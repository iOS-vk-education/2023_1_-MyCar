//
//  InsurenceView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 20.12.2023.
//

import Foundation
import UIKit

protocol InsurenceViewDelegate: AnyObject {
    func didTapChangeButton()
    func didTapImage()
    func didTapDateButton()
    
}

class InsurenceView: UIView {
    
    
    weak var delegate: InsurenceViewDelegate?
    
    private var car: CarViewModel
    private var carTag: Int
    
    private var date = String()
    
    var insurenceImage = UIImageView()
    
    private let changeButton = UIButton()
    
    private var dateLabel = UILabel()
    
    private let dateButton = UILabel()
    
    
    init(car: CarViewModel, carTag: Int) {
        self.car = car
        self.carTag = carTag
        super.init(frame: .zero)
//        self.backgroundColor = .gray
        self.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        
        setupImage()
        setupChangeButton()
        setupDateLabel()
        setupDateButton()
        addTapGestureToImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupImage() {
        self.addSubview(insurenceImage)
//        insurenceImage.image = UIImage(named: "jeep")
        if (car.insurenceImage != nil) {
            insurenceImage.image = car.insurenceImage
        }else {
            insurenceImage.image = UIImage(named: "nophoto")
        }
        

        insurenceImage.contentMode = .scaleToFill
        insurenceImage.layer.cornerRadius = 4 // Set half of the desired width/height for a circular shape
        insurenceImage.clipsToBounds = true // Необходимо установить в true, чтобы обрезать изображение внутри рамки carImageView

        insurenceImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            insurenceImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            insurenceImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 21), // Center vertically
            insurenceImage.widthAnchor.constraint(equalToConstant: 300), // Set your desired width
            insurenceImage.heightAnchor.constraint(equalToConstant: 400) // Set your desired height
            
        ])
    }
    
    func updateImage(_ image: UIImage) {
        insurenceImage.image = image
    }
    
    private func setupChangeButton () {
        
        self.addSubview(changeButton)

        changeButton.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        
        changeButton.setTitle("Изменить изображение", for: .normal)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.backgroundColor = .black
        changeButton.layer.cornerRadius = 4
        
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeButton.topAnchor.constraint(equalTo: insurenceImage.bottomAnchor, constant: 21),
            changeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 300),
            changeButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    
    
    private func setupDateLabel() {
        self.addSubview(dateLabel)

        dateLabel.text = "Страховка заканчивается:"
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 22)
        dateLabel.textAlignment = .left
        
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 21),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            changeButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    private func setupDateButton() {
        self.addSubview(dateButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateButton))
        dateButton.addGestureRecognizer(tapGesture)
        dateButton.isUserInteractionEnabled = true

        date = car.insurenceDate ?? "Введите дату окончания страховки"
        
        dateButton.text = date
        dateButton.textColor = .white
        dateButton.font = UIFont.boldSystemFont(ofSize: 22)
        dateButton.textAlignment = .center


        dateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            dateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
    func updateDate(_ date: String) {
        dateButton.text = date
    }
   
        
    private func addTapGestureToImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        insurenceImage.addGestureRecognizer(tapGesture)
        insurenceImage.isUserInteractionEnabled = true
    }
    
    @objc private func didTapImage() {
            delegate?.didTapImage()
        }
    
    @objc private func didTapChangeButton () {
        delegate?.didTapChangeButton()
    }
    
    @objc private func didTapDateButton () {
        delegate?.didTapDateButton()
    }
    
}




