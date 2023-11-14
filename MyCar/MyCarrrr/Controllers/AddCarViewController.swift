//
//  AddCarViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 13.11.2023.
//

import UIKit



class AddCarViewController: UIViewController {
    
    private let model: HomeCarsModel
    
    var updateTableCompletion: (() -> Void)?
    
    private var contentView: AddCarView {
            return view as! AddCarView
        }
    
    override func loadView() {
        view = AddCarView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateButtonTappedHandler = { [weak self] in
            self?.saveCar()
        }
        contentView.cancelButtonTappedHandler = { [weak self] in
            self?.cancelAdd()
        }
        contentView.addVINButtonTappedHandler = { [weak self] in
            self?.callAlert()
        }

    }
    
    init(model: HomeCarsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cancelAdd() {
        dismiss(animated: true)
    }
    
    private func saveCar() {
        
        model.addCar(CarViewModel(manufacturer: contentView.carBrandTextField.text ?? "",
                                  milleage: Int(contentView.carMileageTextField.text ?? "") ?? 0,
                                   purchaseDate: "",
                                  vinNumber: contentView.vinNumberTextField.text ?? ""))
        
        
        
        updateTableCompletion?()
        print(model.allCars())
        print("--------------------------------------------------")
        // Закрытие AddCarViewController
        dismiss(animated: true)
    }
    
    private func callAlert() {
        let alert = UIAlertController(title: "Добавить новую машину", message: "Введите VIN автомобиля", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "VIN code"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [self] _ in
            guard let field = alert.textFields, field.count == 1 else {
                return
            }
            let vinCodeField = field[0]
            guard let vinCode = vinCodeField.text, !vinCode.isEmpty && vinCode.count == 17 else{
                let errorAlert = UIAlertController(title: "Ошибка", message: "Некорректный VIN код", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(errorAlert, animated: true)
                return
            }
//            let api = APICaller(vin: vinCode)
//            let names = api.getBrandAndModel()
//
//            let words = names.components(separatedBy: "_")
//
//
//            contentView.carBrandTextField.text = words[0]
//            contentView.carModelTextField.text = words[1]
//            contentView.vinNumberTextField.text = vinCode
        }))
        present(alert, animated: true)
    }

}


