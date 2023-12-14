//
//  MileageViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 08.12.2023.
//

import UIKit


class MileageViewController: UIViewController {
    
    private let tag: Int
    private let model: HomeCarsModel
    private var contentView: MileageView!
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
        contentView = MileageView(car: model.car(index: tag))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}

extension MileageViewController: MileageViewDelegate {
    func didTapMileageButton(_ mileage: Int) {
        model.updateMileage(tag, mileage: mileage)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
    }
    
}





