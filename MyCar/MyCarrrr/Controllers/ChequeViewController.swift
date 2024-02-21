//
//  ChequeButtonViewController.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.12.2023.
//

import Foundation
import UIKit
import SwiftPhotoGallery

class ChequeViewController: UIViewController, ChequeViewDelegate  {
    
    
    private let carTag: Int
    private let tag: Int
    private let model: HomeCarsModel
    
    let imagePicker = UIImagePickerController()
    
    private var contentView: ChequeView!
    
    private var car: CarViewModel
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        imagePicker.delegate = self
        


    }
    
    init(model: HomeCarsModel, carTag: Int, tag: Int) {
        self.model = model
        self.carTag = carTag
        self.tag = tag
        self.car = model.car(index: carTag)
        super.init(nibName: nil, bundle: nil)
        contentView = ChequeView(car: car, carTag: carTag, workTag: tag)
        
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
    
    
    func didTapImage() {
        
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)

        gallery.backgroundColor = UIColor.black
//        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
//        gallery.currentPageIndicatorTintColor = UIColor.white
        gallery.hidePageControl = true

        present(gallery, animated: true, completion: nil)
        
//        if let image = contentView.chequeImage.image {
//            let fullscreenImageView = UIImageView(image: image)
//            fullscreenImageView.isUserInteractionEnabled = true
//            fullscreenImageView.contentMode = .scaleAspectFit
//            fullscreenImageView.frame = UIScreen.main.bounds
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
//            fullscreenImageView.addGestureRecognizer(tapGesture)
//            UIApplication.shared.keyWindow?.addSubview(fullscreenImageView)
//        }
    }
}





extension ChequeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            car.insurenceImage = selectedImage
            model.updateChequeImage(carTag, workIndex: tag, selectedImage)
            
//            let img = model.car(index: carTag).insurenceImage ?? UIImage(named: "nophoto")
            contentView.updateImage(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension ChequeViewController: SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return 1
    }

    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return contentView.chequeImage.image
    }

    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
}
