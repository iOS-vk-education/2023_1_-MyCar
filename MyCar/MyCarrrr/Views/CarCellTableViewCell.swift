import UIKit


protocol CellViewDelegate: AnyObject {
    func didTapButtonOnCell(_ tag: Int)
    func didTapMileageButtonOnCell(_ tag: Int)
    func didTapInsuranceButtonOnCell(_ tag: Int)
    func didTapEditCarButtonOnCell(_ tag: Int)
}

class CarCellTableViewCell: UITableViewCell {
    
    weak var tableView: UITableView?
    
    static let identifier = "carCell"
    
    private let carLabel = UILabel()
    private let carModel = UILabel()
   
    private let nextTOFrame = UIView()
    private let nextTOLabel = UILabel()
    
    private let nextInsuranceFrame = UIView()
    private let nextInsuranceLabel = UILabel()
    
    private let yearFrame = UIView()
    private let yearLabel = UILabel()
    
    private let carImageView = UIImageView()

    
    private let toButtonView = TOButtonView()
    private let insuranceButtonView = InsuranceButtonView()
    private let mileageButtonView = MileageButtonView()
    
    weak var delegate: CellViewDelegate?



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
            
        setupContentView()
        setupCarLabel()
        setupCarModel()
        
        setupNextTOFrame()
        setupNextInsuranceFrame()
        setupNextYearFrame()
        setupCarImageView()
        
        setupMileageView()
        setupTOView()
        setupInsuranceView()
        
        
        
        
        toButtonView.delegate = self
        mileageButtonView.delegate = self
        insuranceButtonView.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        contentView.addGestureRecognizer(tapGesture)
        contentView.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 36
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
        selectedBackgroundView?.layer.cornerRadius = 15
        
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
        carLabel.textColor = .white
        carLabel.font = UIFont.boldSystemFont(ofSize: 30)
        carLabel.textAlignment = .center
        
        contentView.addSubview(carLabel)
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            carLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 21)
            ])
    }
    
    private func setupCarModel() {
        carModel.textColor = .white
        carModel.font = UIFont.boldSystemFont(ofSize: 30)
        carModel.textAlignment = .center
        
        contentView.addSubview(carModel)
        carModel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carModel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            carModel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 21)
            ])
    }
    
    private func setupNextTOFrame() {
        nextTOFrame.layer.cornerRadius = 4
        nextTOFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(nextTOFrame)

        nextTOFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextTOFrame.topAnchor.constraint(equalTo: carModel.bottomAnchor, constant: 10),
            nextTOFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            nextTOFrame.widthAnchor.constraint(equalToConstant: 210),
            nextTOFrame.heightAnchor.constraint(equalToConstant: 33)
        ])

        self.addSubview(nextTOLabel)
        nextTOLabel.textColor = .white
        nextTOLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nextTOLabel.textAlignment = .center

        nextTOLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextTOLabel.topAnchor.constraint(equalTo: nextTOFrame.topAnchor, constant: 8),
            nextTOLabel.centerXAnchor.constraint(equalTo: nextTOFrame.centerXAnchor),
        ])
    }
    
    private func setupNextInsuranceFrame() {
        nextInsuranceFrame.layer.cornerRadius = 4
        nextInsuranceFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(nextInsuranceFrame)

        nextInsuranceFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextInsuranceFrame.topAnchor.constraint(equalTo: nextTOFrame.bottomAnchor, constant: 10),
            nextInsuranceFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            nextInsuranceFrame.widthAnchor.constraint(equalToConstant: 210),
            nextInsuranceFrame.heightAnchor.constraint(equalToConstant: 33)
        ])

        self.addSubview(nextInsuranceLabel)
        nextInsuranceLabel.textColor = .white
        nextInsuranceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nextInsuranceLabel.textAlignment = .center

        nextInsuranceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextInsuranceLabel.topAnchor.constraint(equalTo: nextInsuranceFrame.topAnchor, constant: 8),
            nextInsuranceLabel.centerXAnchor.constraint(equalTo: nextInsuranceFrame.centerXAnchor),
        ])
    }
    
    private func setupNextYearFrame() {
        yearFrame.layer.cornerRadius = 4
        yearFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(yearFrame)

        yearFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearFrame.topAnchor.constraint(equalTo: nextTOFrame.bottomAnchor, constant: 10),
            yearFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            yearFrame.widthAnchor.constraint(equalToConstant: 99),
            yearFrame.heightAnchor.constraint(equalToConstant: 33)
        ])

        self.addSubview(yearLabel)
        yearLabel.textColor = .white
        yearLabel.font = UIFont.boldSystemFont(ofSize: 14)
        yearLabel.textAlignment = .center

        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: yearFrame.topAnchor, constant: 8),
            yearLabel.centerXAnchor.constraint(equalTo: yearFrame.centerXAnchor),
        ])
    }
    
    
    
    
    private func setupCarImageView() {
        contentView.addSubview(carImageView)
        carImageView.image = UIImage(named: "jeep") // Specify the image name
        carImageView.contentMode = .scaleToFill
        carImageView.layer.cornerRadius = 15 // Set half of the desired width/height for a circular shape
        carImageView.clipsToBounds = true // Необходимо установить в true, чтобы обрезать изображение внутри рамки carImageView

        carImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21), // Adjust the leading anchor
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21), // Center vertically
            carImageView.widthAnchor.constraint(equalToConstant: 99), // Set your desired width
            carImageView.heightAnchor.constraint(equalToConstant: 99) // Set your desired height
            
        ])
    }
    
    private func setupMileageView() {
        contentView.addSubview(mileageButtonView)
        mileageButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mileageButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            mileageButtonView.topAnchor.constraint(equalTo: nextInsuranceFrame.bottomAnchor, constant: 15),
            mileageButtonView.widthAnchor.constraint(equalToConstant: 99),
            mileageButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    private func setupTOView() {
        contentView.addSubview(toButtonView)
        toButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toButtonView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            toButtonView.topAnchor.constraint(equalTo: nextInsuranceFrame.bottomAnchor, constant: 15),
            toButtonView.widthAnchor.constraint(equalToConstant: 99),
            toButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    private func setupInsuranceView() {
        contentView.addSubview(insuranceButtonView)
        insuranceButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            insuranceButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            insuranceButtonView.topAnchor.constraint(equalTo: nextInsuranceFrame.bottomAnchor, constant: 15),
            insuranceButtonView.widthAnchor.constraint(equalToConstant: 99),
            insuranceButtonView.heightAnchor.constraint(equalToConstant: 99)
        ])
    }
    
    @objc func didTapCell() {
        didTapEditCarButtonOnCell(tag)
        print(tag)
    }
    
    
    func update(with car: CarViewModel?) {
        carLabel.text = String(car!.manufacturer)
        carModel.text = String(car!.model)
        mileageButtonView.updateMileageLabel(car!.milleage)
        
        yearLabel.text = String(car!.purchaseDate) + " Года"
        
        carImageView.image = car!.carImage
        

        if (car!.nextTODate != nil) {
            nextTOLabel.text = "Следующее ТО: \(car!.nextTODate!)"
        }else {
            nextTOLabel.text = "Нет запланированных ТО"
        }
        

        if (car!.insurenceDate != nil) {
            nextInsuranceLabel.text = "Страховка до: \(car!.insurenceDate!)"
        }else {
            nextInsuranceLabel.text = "Стаховой полис отсутствует"
        }

    }

}

extension CarCellTableViewCell: TOButtonViewDelegate {

    func didTapMileageButton() {
        didTapMileageButtonOnCell(tag)
    }
    
    func didTapInsuranceButton() {
        didTapInsuranceButtonOnCell(tag)
    }
    
    func didTapTOButton() {
        didTapButtonOnCell(tag)
    }
    
}

extension CarCellTableViewCell: CellViewDelegate {
    func didTapEditCarButtonOnCell(_ tag: Int) {
        delegate?.didTapEditCarButtonOnCell(tag)
    }
    
    func didTapMileageButtonOnCell(_ tag: Int) {
        delegate?.didTapMileageButtonOnCell(tag)
    }
    
    func didTapInsuranceButtonOnCell(_ tag: Int) {
        delegate?.didTapInsuranceButtonOnCell(tag)
    }
    
    func didTapButtonOnCell(_ tag: Int) {
        delegate?.didTapButtonOnCell(tag)
    }
    

}
