//
//  ChequeButtonView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 07.12.2023.
//

import Foundation
import UIKit

//protocol TOButtonViewDelegate: AnyObject {
//    func didTapButton()
//}


class ChequeButtonView: UIView {
    
//    weak var delegate: TOButtonViewDelegate?

    private let label = UILabel()

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
        self.layer.cornerRadius = 4
        
        
        label.text = "Квитанция"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc
    private func didTapButton() {
//            delegate?.didTapButton()
        
        print("Квитанция button pressed")
        }
}
