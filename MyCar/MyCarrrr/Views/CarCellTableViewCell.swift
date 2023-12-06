import UIKit


protocol CellViewDelegate: AnyObject {
    func didTapButtonOnCell()
}

class CarCellTableViewCell: UITableViewCell {
    
    
    static let identifier = "carCell"
    
    private let carLabel = UILabel()
    private let carModel = UILabel()
    private let yearLabel = UILabel()
    private let milleageLabel = UILabel()
    
    private let carImageView = UIImageView()

    
    private let toButtonView = TOButtonView()
    private let insuranceButtonView = InsuranceButtonView()
    private let mileageButtonView = MileageButtonView()
    
    weak var delegate: CellViewDelegate?



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .darkGray
            
        setupContentView()
        setupCarLabel()
        setupCarModel()
        setupCarMilleage()
        setupCarYear()
        setupCarImageView()
        setupMileageView()
        setupTOView()
        setupInsuranceView()
        
        
        
        toButtonView.delegate = self

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .init(UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1.0))
//        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 36
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: 361),
            contentView.heightAnchor.constraint(equalToConstant: 307)])
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
    
    private func setupCarImageView() {
        contentView.addSubview(carImageView)
        carImageView.image = UIImage(named: "bmw5") // Specify the image name
        carImageView.contentMode = .scaleToFill
        carImageView.layer.cornerRadius = 70 // Set half of the desired width/height for a circular shape
        carImageView.layer.masksToBounds = true // Clip to bounds for a circular shape
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Adjust the leading anchor
            carImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // Center vertically
            carImageView.widthAnchor.constraint(equalToConstant: 140), // Set your desired width
            carImageView.heightAnchor.constraint(equalToConstant: 140) // Set your desired height
            
        ])
    }
    
    private func setupMileageView() {
        contentView.addSubview(mileageButtonView)
        mileageButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mileageButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mileageButtonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mileageButtonView.widthAnchor.constraint(equalToConstant: 99),
            mileageButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    private func setupTOView() {
        contentView.addSubview(toButtonView)
        toButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 110),
            toButtonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            toButtonView.widthAnchor.constraint(equalToConstant: 99),
            toButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    private func setupInsuranceView() {
        contentView.addSubview(insuranceButtonView)
        insuranceButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            insuranceButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 210),
            insuranceButtonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            insuranceButtonView.widthAnchor.constraint(equalToConstant: 99),
            insuranceButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    
  
    
    
    
    
    func update(with car: CarViewModel?) {
        carLabel.text = "Manufacturer: " + String(car!.manufacturer)
        carModel.text = "Model: " + String(car!.model)
        yearLabel.text = "Year: " + String(car!.purchaseDate)
        milleageLabel.text = "Milleage: " + String(car!.milleage)

    }

}

extension CarCellTableViewCell: TOButtonViewDelegate {
    func didTapButton() {
        didTapButtonOnCell()
    }
}

extension CarCellTableViewCell: CellViewDelegate {
    func didTapButtonOnCell() {
        delegate?.didTapButtonOnCell()
    }
}
