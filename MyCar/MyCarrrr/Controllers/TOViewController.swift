//
//  TOViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

class TOViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = TOView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}



