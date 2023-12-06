//
//  TOView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

class TOView: UIView, UITableViewDelegate {
    
    weak var delegate: ViewToViewController?
    
    
    private let carLabel = UILabel()
    private let workListLabel = UILabel()
    
    private let labelFrame = UIView()
    private let mainContentFrame = UIView()
    
    private let dateFrame = UIView()
    private let dateLabel = UILabel()
    
    private let mileageFrame = UIView()
    private let mileageLabel = UILabel()
    
    private let contentFrame = UIView()
    private let contentLabel = UILabel()
    
    private let priceFrame = UIView()
    private let priceLabel = UILabel()
    
    private let chequeFrame = UIView()
    private let chequeLabel = UILabel()
    
    
    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setupHeaderLabel("BMW 7 Series")
        setupWorkListLabel()
        setupFrameForLabel()
        setupFrameForContent()
        setupDateFrame()
        setupMileageFrame()
        setupContentFrame()
        setupPriceFrame()
        setupСhequeFrame()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupHeaderLabel( _ label: String) {
        self.addSubview(carLabel)
        carLabel.text = label
        carLabel.textColor = .white
        carLabel.font = UIFont.boldSystemFont(ofSize: 22)
        carLabel.textAlignment = .center
        
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            carLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            carLabel.widthAnchor.constraint(equalToConstant: 390),
            carLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func setupWorkListLabel () {
        self.addSubview(workListLabel)
        workListLabel.text = "Список работ"
        workListLabel.textColor = .white
        workListLabel.font = .systemFont(ofSize: 18)
        workListLabel.textAlignment = .center
        
        workListLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workListLabel.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: 4),
            workListLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            workListLabel.widthAnchor.constraint(equalToConstant: 390),
            workListLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func setupFrameForLabel() {
        
//        labelFrame = UIView(frame: CGRect(x: 17, y: 11, width: 361, height: 80))
        labelFrame.layer.cornerRadius = 15
        labelFrame.backgroundColor = .black
        self.addSubview(labelFrame)
        labelFrame.addSubview(carLabel)
        labelFrame.addSubview(workListLabel)
        
        labelFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            labelFrame.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            labelFrame.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),

            labelFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            labelFrame.widthAnchor.constraint(equalToConstant: 361),
            labelFrame.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupFrameForContent() {
        mainContentFrame.layer.cornerRadius = 15
        mainContentFrame.backgroundColor = .black
        self.addSubview(mainContentFrame)
        

        mainContentFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainContentFrame.topAnchor.constraint(equalTo: labelFrame.bottomAnchor, constant: 11),
            mainContentFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            mainContentFrame.widthAnchor.constraint(equalToConstant: 361),
            mainContentFrame.heightAnchor.constraint(equalToConstant: 188)
        ])
    }
    
    private func setupDateFrame() {
        dateFrame.layer.cornerRadius = 4
        dateFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(dateFrame)

        dateFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateFrame.topAnchor.constraint(equalTo: mainContentFrame.topAnchor, constant: 21),
            dateFrame.leadingAnchor.constraint(equalTo: mainContentFrame.leadingAnchor, constant: 21),
            dateFrame.widthAnchor.constraint(equalToConstant: 154),
            dateFrame.heightAnchor.constraint(equalToConstant: 33)
        ])
        
        self.addSubview(dateLabel)
        dateLabel.text = "Дата: 20.02.2023"
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .center
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dateFrame.topAnchor, constant: 8),
            dateLabel.centerXAnchor.constraint(equalTo: dateFrame.centerXAnchor),
        ])
    }
    
    private func setupMileageFrame() {
        mileageFrame.layer.cornerRadius = 4
        mileageFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(mileageFrame)

        mileageFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mileageFrame.topAnchor.constraint(equalTo: mainContentFrame.topAnchor, constant: 21),
            mileageFrame.trailingAnchor.constraint(equalTo: mainContentFrame.trailingAnchor, constant: -21),
            mileageFrame.widthAnchor.constraint(equalToConstant: 154),
            mileageFrame.heightAnchor.constraint(equalToConstant: 33)
        ])
        
        self.addSubview(mileageLabel)
        mileageLabel.text = "Пробег: 100000 Км"
        mileageLabel.textColor = .white
        mileageLabel.font = .systemFont(ofSize: 14)
        mileageLabel.textAlignment = .center
        
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mileageLabel.topAnchor.constraint(equalTo: mileageFrame.topAnchor, constant: 8),
            mileageLabel.centerXAnchor.constraint(equalTo: mileageFrame.centerXAnchor)
        ])
    }
    
    private func setupContentFrame() {
        contentFrame.layer.cornerRadius = 4
        contentFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(contentFrame)

        contentFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentFrame.topAnchor.constraint(equalTo: mileageFrame.bottomAnchor, constant: 11),
            contentFrame.leadingAnchor.constraint(equalTo: mainContentFrame.leadingAnchor, constant: 21),
            contentFrame.widthAnchor.constraint(equalToConstant: 319),
            contentFrame.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        self.addSubview(contentLabel)
        contentLabel.text = "Замена масла - 700 р \n Мойка - 500 р"
        contentLabel.numberOfLines = 2
        contentLabel.textColor = .white
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textAlignment = .center
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentFrame.topAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: contentFrame.leadingAnchor, constant: 11)
        ])
    }
    
    private func setupPriceFrame() {
        priceFrame.layer.cornerRadius = 4
        priceFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(priceFrame)

        priceFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceFrame.bottomAnchor.constraint(equalTo: mainContentFrame.bottomAnchor, constant: -21),
            priceFrame.leadingAnchor.constraint(equalTo: mainContentFrame.leadingAnchor, constant: 21),
            priceFrame.widthAnchor.constraint(equalToConstant: 154),
            priceFrame.heightAnchor.constraint(equalToConstant: 33)
        ])
        
        self.addSubview(priceLabel)
        priceLabel.text = "Стоимость: 20000 р"
        priceLabel.textColor = .white
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textAlignment = .center
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: priceFrame.topAnchor, constant: 8),
            priceLabel.centerXAnchor.constraint(equalTo: priceFrame.centerXAnchor)
        ])
    }
    
    //TODO: это должно быть кнопкой
    private func setupСhequeFrame() {
        chequeFrame.layer.cornerRadius = 4
        chequeFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(chequeFrame)

        chequeFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chequeFrame.bottomAnchor.constraint(equalTo: mainContentFrame.bottomAnchor, constant: -21),
            chequeFrame.trailingAnchor.constraint(equalTo: mainContentFrame.trailingAnchor, constant: -21),
            chequeFrame.widthAnchor.constraint(equalToConstant: 154),
            chequeFrame.heightAnchor.constraint(equalToConstant: 33)
        ])
        
        self.addSubview(chequeLabel)
        chequeLabel.text = "Квитанция"
        chequeLabel.textColor = .white
        chequeLabel.font = .systemFont(ofSize: 14)
        chequeLabel.textAlignment = .center
        
        chequeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chequeLabel.topAnchor.constraint(equalTo: chequeFrame.topAnchor, constant: 8),
            chequeLabel.centerXAnchor.constraint(equalTo: chequeFrame.centerXAnchor)
        ])
    }
    
    
}



