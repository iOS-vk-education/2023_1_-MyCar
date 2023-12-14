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
    func addWork(carIndex: Int, work: WorkModel)
}


class TOViewController: UIViewController {
    
    private let carTag: Int
    private let model: HomeCarsModel
    
    private var contentView: TOView!
    
    private var car: CarViewModel
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.toDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(workTableDataUpdated), name: .workTableDataUpdated, object: nil)

    }
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.carTag = tag
        self.car = model.car(index: carTag)
        super.init(nibName: nil, bundle: nil)
        contentView = TOView(car: model.car(index: carTag))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goToMileageScreen(_ tag: Int) {
        let mileageViewController = TOMileageViewController(carTag: carTag, tag: tag, model: model)
    
        mileageViewController.modalPresentationStyle = .pageSheet
        mileageViewController.sheetPresentationController?.detents = [.medium()]
        present(mileageViewController, animated: true)
    }
    
    @objc func workTableDataUpdated() {
            contentView.updateTable()
        }
    
    @objc func addWorkAction(_ sender: UIBarButtonItem) {
        let tag = sender.tag // Retrieve the tag from the sender
        let mileage = String(model.car(index: tag).milleage)
        // Получить текущую дату и время
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        model.addWork(WorkModel(date: dateString,
                                mileage: mileage,
                                content: "",
                                price: "100000 Руб."),
                                tag)
//        contentView.toTable.reloadData()
        NotificationCenter.default.post(name: .workTableDataUpdated, object: nil)

//        print(model.allWorks(tag))
    }
   

}
//MARK: fix
extension TOViewController : TOViewControllerDelegate {
    func addWork(carIndex: Int, work: WorkModel) {
        print("addwork")
    }
    
    func works(carIndex: Int) -> [WorkModel] {
//        var car = model.car(index: carIndex)
        return model.allWorks(carIndex)
    }
    
    func work(carIndex: Int, workIndex: Int) -> WorkModel {
        model.work(carIndex: carIndex, workIndex: workIndex)
    }
    
    
    //    func removeWork(index: Int) {
    //        model.remove(at: index)
    //    }
}

extension Notification.Name {
    static let workTableDataUpdated = Notification.Name("WorkTableDataUpdated")
}

extension TOViewController: TOCellViewDelegate {
    func didTapDateButtonOnCell(_ tag: Int) {
        print("didTapDateButtonOnCell VC")
        
    }
    
    func didTapMileageButtonOnCell(_ tag: Int) {
        goToMileageScreen(tag)
        print(tag)

    }
    
    func didTapPriceButtonOnCell(_ tag: Int) {
        print("price VC")

    }
}



