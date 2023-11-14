//
//  ViewController.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

protocol ViewToViewController: AnyObject {
    func cars() -> [CarViewModel]
    func removeCar(index: Int)
    func goToAnotherScreen()
}

class MyCarsViewController: UIViewController {
    
    private let contentView = MyCarsView()
    private let model: HomeCarsModel
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        contentView.setTapOnAddCarButton {
            self.addCar()
        }
    }
    
    private func addCar() {
        let alert = UIAlertController(title: "Добавить новую машину", message: "Напишите марку новой машины", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Марка"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [self] _ in
            guard let field = alert.textFields, field.count == 1 else {
                return
            }
            let carField = field[0]
            guard let carName = carField.text, !carName.isEmpty else{
                print("Напишите правильное значение")
                return
            }
            
            let cellContent = CellContent(manufacturer: carName)
            //contentView.cars.append(cellContent)
            model.addCar(CarViewModel(manufacturer: "",
                                      milleage: 0,
                                      purchaseDate: "",
                                      color: "",
                                      vinNumber: ""))
            contentView.updateTable()
        }))
        present(alert, animated: true)
    }

}

extension MyCarsViewController: ViewToViewController {
    func cars() -> [CarViewModel] {
        model.allCars()
    }
    
    func removeCar(index: Int) {
        model.remove(at: index)
    }
    
    func goToAnotherScreen() {
        let vc = MapViewController()
        present(vc, animated: true)
    }
}

