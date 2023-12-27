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
    
    let imagePicker = UIImagePickerController()
    private var image: UIImage
    
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
        contentView.imageButtonTappedHandler = { [weak self] in
            self?.changeImage()
        }
        imagePicker.delegate = self
        
        contentView.carBrandTextField.delegate = self
        contentView.carModelTextField.delegate = self
        contentView.carMileageTextField.delegate = self
        contentView.carYearTextField.delegate = self
        contentView.vinNumberTextField.delegate = self
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.tag = tag
        self.image = model.car(index: tag).carImage!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        contentView.scrollView.isScrollEnabled = true
        contentView.scrollView.contentOffset = CGPoint(x: 0, y: 200)
        contentView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        contentView.scrollView.isScrollEnabled = false
        contentView.scrollView.contentOffset = CGPoint.zero
    }

    private func changeImage() {
        // вызов метода определяющего тип выбора изображения (camera / photo library)
        let actionSheet = UIAlertController(title: nil, message: "Выберите изображение", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func photoLibrary() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func cancelAdd() {
        dismiss(animated: true)
    }
    
    private func updateCar() {
        if (contentView.carBrandTextField.text == "" ||  contentView.carModelTextField.text == "") {
            let errorAlert = UIAlertController(title: "Ошибка", message: "Поля марка и модель не могут быть пустыми", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(errorAlert, animated: true)

            return
        }
        model.editCar(CarViewModel(manufacturer: contentView.carBrandTextField.text ?? "",
                                  model: contentView.carModelTextField.text ?? "",
                                  milleage: Int(contentView.carMileageTextField.text ?? "") ?? 0,
                                  purchaseDate: contentView.carYearTextField.text ?? "",
                                   vinNumber: contentView.vinNumberTextField.text ?? "",
                                  carImage: image
                                  ), tag)
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

extension EditCarViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            image = selectedImage
            contentView.updateImage(selectedImage)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditCarViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрыть клавиатуру при нажатии на Return
        textField.resignFirstResponder()
        return true
    }
}

