//
//  ViewController.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

class MyCarsViewController: UIViewController {
    
    private let contentView = MyCarsView()
        
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            let cellContent = CellContent(carMark: carName)
            contentView.cars.append(cellContent)
            contentView.carsTable.reloadData()
        }))
        present(alert, animated: true)
    }

}

