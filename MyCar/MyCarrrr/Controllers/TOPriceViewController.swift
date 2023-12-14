//
//  TOPriceViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 14.12.2023.
//

import Foundation
import UIKit


class TOPriceViewController: UIViewController {
    
    private let carTag: Int
    private let tag: Int
    private var model: HomeCarsModel
    private var contentView: WorkEditView!
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
        contentView = WorkEditView(car: model.car(index: carTag), label: label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}

extension TOPriceViewController: MileageViewDelegate {
    func didTapMileageButton(_ mileage: Int) {
        model.updateTOPrice(carTag, workIndex: tag, mileage)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .workTableDataUpdated, object: nil)
    }
    
}





