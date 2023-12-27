//
//  InsurenceViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 20.12.2023.
//

import Foundation
import UIKit

class InsurenceViewController: UIViewController, InsurenceViewDelegate  {
    
    private let carTag: Int
    private let model: HomeCarsModel
    
    let imagePicker = UIImagePickerController()
    
    private var contentView: InsurenceView!
    
    private var car: CarViewModel
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        imagePicker.delegate = self
        


    }
    
    init(model: HomeCarsModel, tag: Int) {
        self.model = model
        self.carTag = tag
        self.car = model.car(index: carTag)
        super.init(nibName: nil, bundle: nil)
        contentView = InsurenceView(car: model.car(index: carTag), carTag: carTag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapChangeButton() {
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
    
    func didTapImage() {
        if let image = contentView.insurenceImage.image {
            let fullscreenImageView = UIImageView(image: image)
            fullscreenImageView.isUserInteractionEnabled = true
            fullscreenImageView.contentMode = .scaleAspectFit
            fullscreenImageView.frame = UIScreen.main.bounds
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
            fullscreenImageView.addGestureRecognizer(tapGesture)
            UIApplication.shared.keyWindow?.addSubview(fullscreenImageView)
        }
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
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
    
    
    func didTapDateButton() {
        let dateViewController = InsurenceDateViewController(carTag: carTag, model: model, label: "Обновление даты")
        dateViewController.dateDelegate = self
        dateViewController.modalPresentationStyle = .pageSheet
        dateViewController.sheetPresentationController?.detents = [.medium()]
        present(dateViewController, animated: true)
    }
    
}

extension InsurenceViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            car.insurenceImage = selectedImage
            model.updateInsuranceImage(selectedImage, carTag)
            let img = model.car(index: carTag).insurenceImage ?? UIImage(named: "nophoto")
            contentView.updateImage(img!)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension InsurenceViewController: InsurenceDateViewControllerDelegate {
    func changeDate(_ date: String) {
        contentView.updateDate(date)
        
        let content = UNMutableNotificationContent()
                content.title = "Заголовок уведомления"
                content.body = "Текст уведомления"

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Ошибка отправки уведомления: (error.localizedDescription)")
                    } else {
                        print("Уведомление успешно отправлено")
                    }
                }
    }
    
    
}



