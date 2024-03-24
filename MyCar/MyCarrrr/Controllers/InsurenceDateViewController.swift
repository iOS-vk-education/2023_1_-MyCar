//
//  InsurenceDateViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 22.12.2023.
//

import Foundation
import UIKit

protocol InsurenceDateViewControllerDelegate: AnyObject {
    func changeDate(_ date: String)
}

class InsurenceDateViewController: UIViewController {
    
    private let carTag: Int
    private var model: HomeCarsModel
    private var contentView: TODateView!
    private let label: String
    
    weak var dateDelegate: InsurenceDateViewControllerDelegate?
    
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

extension InsurenceDateViewController: DateViewDelegate {
    
    func didTapDateButton(_ date: String) {
        model.updateInsuranceDate(carTag, date: date)
        dateDelegate?.changeDate(date)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
    }
    
}





