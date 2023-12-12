import UIKit

class MyCarsView: UIView, UITableViewDelegate {
    
    weak var delegate: ViewToViewController?
    
    private let headerLabel = UILabel()
    private let addCarButton = UIButton()
    private let carsTable = UITableView()
    
    
    private let emptyStateImageView = UIImageView()

    
    init() {
        super.init(frame: .zero)
//        self.backgroundColor = .darkGrayBMW
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTable() {
        carsTable.reloadData()
//        emptyStateImageView.isHidden = !(delegate?.cars().isEmpty ?? true)
    }
    
    func setupUI() {
        setupHeaderLabel()
        setupAddCarButton()
        setupCarTable()
//        setupEmptyStateImageView()

    }
    private func setupEmptyStateImageView() {
        self.addSubview(emptyStateImageView)
        emptyStateImageView.image = UIImage(named: "nocars")
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

    }
    
    private func setupHeaderLabel() {
        self.addSubview(headerLabel)
        headerLabel.text = "Мои автомобили"
        headerLabel.textColor = .white
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
        let addButton = UIButton(type: .contactAdd)
        addButton.setTitle("", for: .normal)
        addButton.addTarget(self, action: #selector(didTapAddCarButton), for: .touchUpInside)
        
        self.addSubview(addButton)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 45),
            addButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    
    private func setupCarTable(){
        self.addSubview(carsTable)
        carsTable.dataSource = self
        carsTable.backgroundColor = .clear
        carsTable.separatorStyle = .none
        carsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carsTable.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            carsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            carsTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            carsTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10), 
            carsTable.widthAnchor.constraint(equalToConstant: 361)
        ])
        
        carsTable.register(CarCellTableViewCell.self, forCellReuseIdentifier: CarCellTableViewCell.identifier)
    }
    
    private func removeItem(at index: Int) {
        delegate?.removeCar(index: index)
    }
    

    @objc private func didTapAddCarButton() {
        delegate?.goToAddScreen()
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
        cell.update(with: car)
        
        cell.tag = indexPath.row
        
        cell.delegate = delegate as? any CellViewDelegate
        
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

