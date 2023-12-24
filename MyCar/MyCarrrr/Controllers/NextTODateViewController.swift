//
//  NextTODateViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.12.2023.
//

import Foundation
import UIKit


class NextTODateViewController: UIViewController {
    
    private let carTag: Int
    private var model: HomeCarsModel
    private var contentView: TODateView!
    private let label: String
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }
    
    init(carTag: Int, model: HomeCarsModel, label: String) {
        self.carTag = carTag
        self.model = model
        self.label = label
        super.init(nibName: nil, bundle: nil)
        contentView = TODateView(car: model.car(index: carTag), label: label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}

extension NextTODateViewController: DateViewDelegate {
    
    func didTapDateButton(_ date: String) {
        model.updateNextTODate(carTag, date)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
    }
    
}





