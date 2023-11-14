//
//
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

class MyCarsView: UIView, UITableViewDelegate {
    
    weak var delegate: ViewToViewController?
    
    private let headerLabel = UILabel()
    private let addCarButton = UIButton()
    private let carsTable = UITableView()
    
    private var tapOnAddCarButton: () -> Void = { }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .yellow
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTable() {
        self.carsTable.reloadData()
    }
    
    func setupUI() {
        setupHeaderLabel()
        setupAddCarButton()
        setupCarTable()
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
    
    private func removeItem(at index: Int) {
        delegate?.removeCar(index: index)
    }
    
    func setTapOnAddCarButton(tapOnAddCarButton: @escaping () -> Void) {
        self.tapOnAddCarButton = tapOnAddCarButton
    }
    
    @objc private func didTapAddCarButton() {
        tapOnAddCarButton()
    }
}

extension MyCarsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.cars().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell( withIdentifier: CarCellTableViewCell.identifier, for: indexPath) as? CarCellTableViewCell else {
            return UITableViewCell()
        }
        let car = delegate?.cars()[indexPath.row]
        //cell.update(with: car)
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
