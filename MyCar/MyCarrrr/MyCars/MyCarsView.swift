//
//  MainScreenView.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

class MyCarsView: UIView, UITableViewDelegate {
    
    private let headerLabel = UILabel()
    let carsTable = UITableView()
    private let addCarButton = UIButton()
    
    var carsMas = [CellContent]()
    
    private var tapOnAddCarButton: () -> Void = { }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .yellow
        setupHeaderLabel()
        setupAddCarButton()
        setupCarTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderLabel() {
        self.addSubview(headerLabel)
        headerLabel.text = "Мои автомобили"
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
        self.addSubview(addCarButton)
        addCarButton.setTitle("+", for: .normal)
        addCarButton.backgroundColor = .black
        addCarButton.layer.cornerRadius = 30
        addCarButton.setTitleColor(.yellow, for: .normal)
        
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addCarButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -85),
            addCarButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            addCarButton.widthAnchor.constraint(equalToConstant: 64),
            addCarButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        addCarButton.addTarget(self, action: #selector(didTapAddCarButton), for: .touchUpInside)
    }
    
    private func setupCarTable(){
        self.addSubview(carsTable)
        carsTable.dataSource = self
        
        carsTable.backgroundColor = .yellow
        carsTable.separatorStyle = .none
        carsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carsTable.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            carsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carsTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            carsTable.widthAnchor.constraint(equalToConstant: 358),
            carsTable.heightAnchor.constraint(equalToConstant: 550)
        ])
        
        carsTable.register(CarCellTableViewCell.self, forCellReuseIdentifier: CarCellTableViewCell.identifier)
    }
    
    func removeItem(at index: Int) {
        carsMas.remove(at: index)
    }
    
    func setTapOnAddCarButton(tapOnAddCarButton: @escaping () -> Void) {
        self.tapOnAddCarButton = tapOnAddCarButton
    }
    
    @objc func didTapAddCarButton() {
        tapOnAddCarButton()
    }
}

extension MyCarsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsMas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCellTableViewCell.identifier, for: indexPath)
        let customCell = cell as? CarCellTableViewCell
        customCell?.update(with: carsMas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

struct CellContent {
    let carMark: String
}
