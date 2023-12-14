//
//  TOCellTableViewCell.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 06.12.2023.
//

import UIKit


protocol TOCellViewDelegate: AnyObject {
//    func didTapButtonOnCell(_ tag: Int)
    func didTapDateButtonOnCell(_ tag: Int)
    func didTapMileageButtonOnCell(_ tag: Int)
    func didTapPriceButtonOnCell(_ tag: Int)
}


class TOCellTableViewCell: UITableViewCell, UITableViewDelegate, UITextFieldDelegate {

    static let identifier = "toCell"

    private let dateFrame = UIView()
    private let dateLabel = UILabel()

    private let mileageFrame = UIView()
    private let mileageLabel = UILabel()

    private let contentFrame = UIView()
    private let contentLabel = UILabel()
    
    private var contentField = UITextField()


    private var contentTextView = UITextView()

    
    
    private let tableView = UITableView()
    private var contentArray: [String] = [""]


    private let priceFrame = UIView()
    private let priceLabel = UILabel()

    private let mainContentFrame = UIView()


    private let updateButton = UIButton()
    private let cancelButton = UIButton()
    
    private let chequeButtonView = ChequeButtonView()
    
    private var contentViewHeightConstraint: NSLayoutConstraint?

    
    weak var cellDelegate: TOCellViewDelegate?



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
            
        setupContentView()
        setupDateFrame()
        setupMileageFrame()
        
        
        
        setupPriceFrame()
        setupChequeButtonView()
        
        
//        setupContentTestView()
//        setupContentTextField()
        setupContentTextView()
        

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
        
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 196)
            contentViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            
            contentView.widthAnchor.constraint(equalToConstant: 361),
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 196)
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
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

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dataFrameTapped))
        dateFrame.addGestureRecognizer(tapGesture)
        dateFrame.isUserInteractionEnabled = true
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mileageFrameTapped))
        mileageFrame.addGestureRecognizer(tapGesture)
        mileageFrame.isUserInteractionEnabled = true
        
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


    
    private func setupContentTextView() {
        contentTextView.backgroundColor = .white
        contentTextView.layer.cornerRadius = 4
        contentTextView.textAlignment = .left
        contentTextView.textColor = .black
        contentTextView.font = .systemFont(ofSize: 14)
        contentTextView.layer.borderWidth = 1.0
        contentTextView.layer.borderColor = UIColor.black.cgColor
        
        contentTextView.isScrollEnabled = false // Disable scrolling

        
        
        contentView.addSubview(contentTextView)
        
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            contentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -64),
            contentTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
        
    }
    
    
    private func setupPriceFrame() {
        priceFrame.layer.cornerRadius = 4
        priceFrame.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.addSubview(priceFrame)

        priceFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            priceFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            priceFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            priceFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            priceFrame.widthAnchor.constraint(equalToConstant: 154),
            priceFrame.heightAnchor.constraint(equalToConstant: 33)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(priceFrameTapped))
        priceFrame.addGestureRecognizer(tapGesture)
        priceFrame.isUserInteractionEnabled = true
        
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
        self.addSubview(chequeButtonView)
        chequeButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chequeButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21),
            chequeButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            chequeButtonView.widthAnchor.constraint(equalToConstant: 154),
            chequeButtonView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    @objc private func dataFrameTapped() {
        didTapDateButtonOnCell(tag)
//        cellDelegate?.didTapPriceButtonOnCell(tag)
    }
    @objc private func mileageFrameTapped() {
        didTapMileageButtonOnCell(tag)

    }
    @objc private func priceFrameTapped() {
        didTapPriceButtonOnCell(tag)

    }
    
    func updateHeigth() {
        
        contentViewHeightConstraint?.constant += 400
        
    }
    
    
    func update(with work: WorkModel?) {

        dateLabel.text = "Дата: " + String(work!.date)
        mileageLabel.text = "Пробег: " + String(work!.mileage)
        contentLabel.text = String(work!.content)
        priceLabel.text = "Цена: " + String(work!.price)
        
    }

}

extension TOCellTableViewCell: TOCellViewDelegate {
    func didTapDateButtonOnCell(_ tag: Int) {
        cellDelegate?.didTapDateButtonOnCell(tag)
        
    }
    
    func didTapMileageButtonOnCell(_ tag: Int) {
        cellDelegate?.didTapMileageButtonOnCell(tag)


    }
    
    func didTapPriceButtonOnCell(_ tag: Int) {
        cellDelegate?.didTapPriceButtonOnCell(tag)


    }
}
