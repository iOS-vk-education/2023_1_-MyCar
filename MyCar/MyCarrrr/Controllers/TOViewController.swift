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
    
    func removeWork(index: Int)
    
    func updateTODate()
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
        contentView = TOView(car: model.car(index: carTag), carTag: carTag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goToMileageScreen(_ tag: Int) {
        let mileageViewController = TOMileageViewController(carTag: carTag, tag: tag, model: model, label: "Обновление пробега")
    
        mileageViewController.modalPresentationStyle = .pageSheet
        mileageViewController.sheetPresentationController?.detents = [.medium()]
        present(mileageViewController, animated: true)
    }
    
    func goToPriceScreen(_ tag: Int) {
        let priceViewController = TOPriceViewController(carTag: carTag, tag: tag, model: model, label: "Обновление стоимости")
    
        priceViewController.modalPresentationStyle = .pageSheet
        priceViewController.sheetPresentationController?.detents = [.medium()]
        present(priceViewController, animated: true)
    }
    
    func goToDateScreen(_ tag: Int) {
        let dateViewController = TODateViewController(carTag: carTag, tag: tag, model: model, label: "Обновление даты")
    
        dateViewController.modalPresentationStyle = .pageSheet
        dateViewController.sheetPresentationController?.detents = [.medium()]
        present(dateViewController, animated: true)
    }
    
    func goToChequeScreen(_ tag: Int) {
        let priceViewController = ChequeViewController(model: model, carTag: carTag, tag: tag)
    
//        priceViewController.modalPresentationStyle = .pageSheet
//        priceViewController.sheetPresentationController?.detents = [.medium()]
        present(priceViewController, animated: true)
    }
    
    func goToUpdateTODateScreen(_ tag: Int) {
        let dateViewController = NextTODateViewController(carTag: carTag, model: model, label: "Обновление даты предстоящего ТО")
    
        dateViewController.modalPresentationStyle = .pageSheet
        dateViewController.sheetPresentationController?.detents = [.medium()]
        present(dateViewController, animated: true)
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
                                price: "0"),
                                tag)
//        contentView.toTable.reloadData()
        NotificationCenter.default.post(name: .workTableDataUpdated, object: nil)

        print(model.allWorks(tag))
    }
   

}
//MARK: fix
extension TOViewController : TOViewControllerDelegate {
    func updateTODate() {
        goToUpdateTODateScreen(carTag)
    }
    
    func removeWork(index: Int) {
        model.removeWork(at: index, carTag: carTag)
    }
    
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
    func didTapChequeButtonOnCell(_ tag: Int) {
        goToChequeScreen(tag)
    }
    
    func didTapDateButtonOnCell(_ tag: Int) {
       goToDateScreen(tag)
        
    }
    
    
    func didTapMileageButtonOnCell(_ tag: Int) {
        goToMileageScreen(tag)

    }
    
    func didTapPriceButtonOnCell(_ tag: Int) {
        goToPriceScreen(tag)

    }
}



