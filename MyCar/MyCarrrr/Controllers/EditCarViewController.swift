//
//  EditCarViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 09.12.2023.
//

import Foundation
import UIKit



class EditCarViewController: UIViewController {
    
    private let model: HomeCarsModel
    private var contentView = EditCarView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateButtonTappedHandler = { [weak self] in
            self?.updateCar()
        }
        contentView.cancelButtonTappedHandler = { [weak self] in
            self?.cancelAdd()
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
    
    private func updateCar() {
        
        model.editCar(CarViewModel(manufacturer: contentView.carBrandTextField.text ?? "",
                                  model: contentView.carModelTextField.text ?? "",
                                  milleage: Int(contentView.carMileageTextField.text ?? "") ?? 0,
                                  purchaseDate: contentView.carYearTextField.text ?? "",
                                  vinNumber: contentView.vinNumberTextField.text ?? ""))
        // Отправка уведомления о том, что данные были обновлены
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
        // Закрытие AddCarViewController
        dismiss(animated: true)
        
    }
    
  
    

}


