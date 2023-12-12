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
    private let tag: Int
    private var contentView = EditCarView()
    
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        contentView.carViewModel = fillField() // Set the carViewModel here
        contentView.updateButtonTappedHandler = { [weak self] in
            self?.updateCar()
        }
        contentView.cancelButtonTappedHandler = { [weak self] in
            self?.cancelAdd()
        }

    }
    
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.tag = tag
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
                                   vinNumber: contentView.vinNumberTextField.text ?? ""), tag)
        // Отправка уведомления о том, что данные были обновлены
        NotificationCenter.default.post(name: .dataUpdated, object: nil)
        dismiss(animated: true)
        
    }
    
}

extension EditCarViewController: EditCarViewDelegate {
    func fillField() -> CarViewModel {
        return model.car(index: tag)
    }

}

extension EditCarViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // do something interesting here!
        print(newImage.size)

        dismiss(animated: true)
    }
}

