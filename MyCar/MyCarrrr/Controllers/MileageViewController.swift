//
//  MileageViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 08.12.2023.
//

import UIKit


class MileageViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = MileageView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        contentView.toDelegate = self
    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}





