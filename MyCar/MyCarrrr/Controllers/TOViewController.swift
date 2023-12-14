//
//  TOViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 02.12.2023.
//

import Foundation
import UIKit

protocol TOViewControllerDelegate: AnyObject {
    func works(carIndex: Int) -> [WorkModel]
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel
}


class TOViewController: UIViewController {
    
    private let tag: Int
    private let model: HomeCarsModel
    private var contentView = TOView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.toDelegate = self
    }
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
//MARK: fix
extension TOViewController : TOViewControllerDelegate {
    func works(carIndex: Int) -> [WorkModel] {
        var car = model.car(index: carIndex)
        return model.allWorks(&car)
    }
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel {
        model.work(carIndex: carIndex, workIndex: workIndex)
    }
    
    
    //    func removeWork(index: Int) {
    //        model.remove(at: index)
    //    }
}



