//
//  TODateViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 14.12.2023.
//

import Foundation
import UIKit


class TODateViewController: UIViewController {
    
    private let carTag: Int
    private let tag: Int
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
    
    init(carTag: Int, tag: Int, model: HomeCarsModel, label: String) {
        self.tag = tag
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

extension TODateViewController: DateViewDelegate {
    
    func didTapDateButton(_ date: String) {
        model.updateTODate(carTag, workIndex: tag, date)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .workTableDataUpdated, object: nil)
    }
    
}





