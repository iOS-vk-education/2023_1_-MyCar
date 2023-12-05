//
//  TOButtonView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 05.12.2023.
//

import Foundation
import UIKit


protocol TOButtonViewDelegate: AnyObject {
    func didTapButton()
}


class TOButtonView: UIView {
    
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
        
        backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1.0)
        self.layer.cornerRadius = 15
        
        imageView.image = UIImage(named: "TO")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10), 
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 27),
            imageView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        label.text = "История\nремонта"
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
            delegate?.didTapButton()
        }
}
