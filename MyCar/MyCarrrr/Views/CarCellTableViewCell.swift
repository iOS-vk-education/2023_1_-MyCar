import UIKit

class CarCellTableViewCell: UITableViewCell {

    static let identifier = "carCell"
    
    private let carLabel = UILabel()
    private let carModel = UILabel()
    private let yearLabel = UILabel()
    private let milleageLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupCarLabel()
        setupCarModel()
        setupCarMilleage()
        setupCarYear()
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
    
    private func setupCarYear() {
        contentView.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            yearLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 76),
            yearLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupCarMilleage() {
        contentView.addSubview(milleageLabel)
        milleageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            milleageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            milleageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 106),
            milleageLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    
    
    func update(with car: CarViewModel?) {
        carLabel.text = "Manufacturer: " + String(car!.manufacturer)
        carModel.text = "Model: " + String(car!.model)
        yearLabel.text = "Year: " + String(car!.purchaseDate)
        milleageLabel.text = "Milleage: " + String(car!.milleage)

    }

}
