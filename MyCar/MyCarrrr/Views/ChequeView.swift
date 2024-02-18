//
//  ChequeView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.12.2023.
//

import Foundation
import UIKit

protocol ChequeViewDelegate: AnyObject {
    func didTapChangeButton()
    func didTapImage()
    
}

class ChequeView: UIView {
    
    weak var delegate: ChequeViewDelegate?

    
    private var car: CarViewModel
    private var carTag: Int
    private var workTag: Int
    
    private var date = String()
    
    var chequeImage = UIImageView()
    
    private let changeButton = UIButton()
    
    private var dateLabel = UILabel()
    
    private let dateButton = UILabel()
    
    
    init(car: CarViewModel, carTag: Int, workTag: Int) {
        self.car = car
        self.carTag = carTag
        self.workTag = workTag
        
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        setupImage()
        setupChangeButton()
        addTapGestureToImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupImage() {
        
        self.addSubview(chequeImage)
        print(tag)
        if (car.works[workTag].workImage != nil) {
            chequeImage.image = car.works[workTag].workImage
        }else {
            chequeImage.image = UIImage(named: "nophoto")
        }
        
        chequeImage.contentMode = .scaleAspectFit
        chequeImage.layer.cornerRadius = 4 // Set half of the desired width/height for a circular shape
        chequeImage.clipsToBounds = true // Необходимо установить в true, чтобы обрезать изображение внутри рамки carImageView
        
        chequeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            insurenceImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -21), // Adjust the leading anchor
            chequeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chequeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 21), // Center vertically
            chequeImage.widthAnchor.constraint(equalToConstant: 300), // Set your desired width
            chequeImage.heightAnchor.constraint(equalToConstant: 600) // Set your desired height
            
        ])
    }
    
    func updateImage(_ image: UIImage) {
        chequeImage.image = image
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
            changeButton.topAnchor.constraint(equalTo: chequeImage.bottomAnchor, constant: 21),
            changeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 21),
            changeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -21),
            changeButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    

    
    
    
    private func addTapGestureToImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        chequeImage.addGestureRecognizer(tapGesture)
        chequeImage.isUserInteractionEnabled = true
    }
    
    @objc private func didTapImage() {
        delegate?.didTapImage()
    }
    
    @objc private func didTapChangeButton () {
        delegate?.didTapChangeButton()
    }

    
}




