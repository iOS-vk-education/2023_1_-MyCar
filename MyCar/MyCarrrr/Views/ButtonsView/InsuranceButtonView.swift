//
//  InsuranceView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 06.12.2023.
//

import Foundation
import UIKit



class InsuranceButtonView: UIView {
    
    weak var delegate: TOButtonViewDelegate?

    private let label = UILabel()

    private let imageView = UIImageView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        // Настройка вашего подвида
        backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.layer.cornerRadius = 15
        
        // Add UIImageView
        imageView.image = UIImage(named: "parking")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 27),
            imageView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        label.text = "Место\nпарковки"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc
    private func didTapButton() {
        delegate?.didTapInsuranceButton()
        }
}
