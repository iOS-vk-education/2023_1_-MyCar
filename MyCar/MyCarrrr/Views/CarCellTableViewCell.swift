//
//  CarCellableViewCell.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

class CarCellTableViewCell: UITableViewCell {

    static let identifier = "carCell"
    
    private let carLabel = UILabel()
    private let carModel = UILabel()
    private let colorLabel = UILabel()
    private let milleageLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupCarLabel()
        setupCarModel()
        setupCarMilleage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .init(UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1.0))
        contentView.layer.cornerRadius = 15
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: 358),
            contentView.heightAnchor.constraint(equalToConstant: 300)])
    }
    
    private func setupCarLabel() {
        contentView.addSubview(carLabel)
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            carLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            carLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupCarModel() {
        contentView.addSubview(carModel)
        carModel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carModel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            carModel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            carModel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupCarMilleage() {
        contentView.addSubview(milleageLabel)
        milleageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            milleageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            milleageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 76),
            milleageLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    func update(with car: CarViewModel?) {
        carLabel.text = String(car!.manufacturer)
        carModel.text = String(car!.model)
        milleageLabel.text = String(car!.milleage)

    }

}
