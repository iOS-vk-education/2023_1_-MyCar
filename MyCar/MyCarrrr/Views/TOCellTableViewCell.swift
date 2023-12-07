//
//  TOCellTableViewCell.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 06.12.2023.
//

import UIKit


class TOCellTableViewCell: UITableViewCell {
    

    static let identifier = "toCell"

    private let dateFrame = UIView()
    private let dateLabel = UILabel()

    private let mileageFrame = UIView()
    private let mileageLabel = UILabel()

    private let contentFrame = UIView()
    private let contentLabel = UILabel()

    private let priceFrame = UIView()
    private let priceLabel = UILabel()

    private let mainContentFrame = UIView()


    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    private let chequeButtonView = ChequeButtonView()
    



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .darkGray
            
        setupContentView()
        setupDateFrame()
        setupMileageFrame()
        setupContentFrame()
        setupPriceFrame()
        setupChequeButtonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 15
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: 361),
            contentView.heightAnchor.constraint(equalToConstant: 196)])
    }
    
 

    private func setupDateFrame() {
        dateFrame.layer.cornerRadius = 4
        dateFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(dateFrame)

        dateFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            dateFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
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
            mileageFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            mileageFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
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
            contentFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
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
            priceFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            priceFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
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
    
    private func setupChequeButtonView() {
        contentView.addSubview(chequeButtonView)
        chequeButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chequeButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            chequeButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            chequeButtonView.widthAnchor.constraint(equalToConstant: 154),
            chequeButtonView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    
    func update(with work: WorkModel?) {

        dateLabel.text = String(work!.date)
        mileageLabel.text = String(work!.mileage)
        contentLabel.text = String(work!.content)
        priceLabel.text = String(work!.price)
        
    }

}

