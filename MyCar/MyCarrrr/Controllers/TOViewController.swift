//
//  TOViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

//protocol TOViewControllerDelegate: AnyObject {
//    func works() -> [WorkModel]
////    func removeWork(index: Int)
//}


class TOViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = TOView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        contentView.delegate = self
    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}

//extension TOViewController : TOViewControllerDelegate {
//    func works() -> [WorkModel] {
//        model.allWorks()
//    }
    
//    func removeWork(index: Int) {
//        model.remove(at: index)
//    }




