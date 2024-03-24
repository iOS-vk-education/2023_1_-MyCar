//
//  DocumentsRow.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 23.03.2024.
//

import Foundation
import SwiftUI
import UIKit

struct DocumentsRow: View {
    
    let index: Int
    let car: CarViewModel
    let updateCarsAction: () -> Void
    
    
    @State private var showingActionSheetSts = false
    @State private var showingActionSheetInsurance = false
    
    @State private var showingEditSts = false
    @State private var showingEditInsurance = false
    
    @State private var showingImagePickerSts = false
    @State private var showingImagePickerInsurence = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    var body: some View {
        
        VStack{
            HStack{
                if let img = car.carImage {
                    Image(uiImage: img)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(.buttonBorder)
                }
                Text(car.manufacturer)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.bottom, 6)
            
            //MARK: - STS image
            HStack() {
                if let img = car.stsImage {
                    Button{
                        withAnimation(.snappy){
                            self.showingActionSheetSts = true
                        }
                    } label: {
                        VStack{
                            Text("СТС")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.top)
                            Spacer()
                            Image(systemName: "doc")
                                .resizable()
                                .frame(width: 32, height: 40)
                                .padding(.bottom)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .sheet(isPresented: $showingActionSheetSts) {
                        StsImageView(image: img, 
                                     showingActionSheetSts: $showingActionSheetSts,
                                     carIndex: index,
                                     updateCarsAction: updateCars)
                    }
                }else {
                    Button{
                        withAnimation(.snappy){
                            self.showingEditSts = true
                        }
                    } label: {
                        VStack{
                            Text("СТС")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.top)
                            Spacer()
                            Image(systemName: "doc.badge.plus")
                                .resizable()
                                .frame(width: 42, height: 50)
                                .padding(.bottom)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .actionSheet(isPresented: $showingEditSts) {
                        ActionSheet(title: Text("Выберите действие"), buttons: [
                            .default(Text("Камера"), action: {
                                self.showingImagePickerSts = true
                                self.sourceType = .camera
                            }),
                            .default(Text("Галерея"), action: {
                                self.showingImagePickerSts = true
                                self.sourceType = .photoLibrary
                            }),
                            .cancel(Text("Отменить"))
                        ])
                    }
                    
                }
                
                
                Spacer()
                
                //MARK: - insurence image
                
                if let img = car.insurenceImage {
                    Button{
                        withAnimation(.snappy){
                            self.showingActionSheetInsurance = true
                        }
                    } label: {
                        VStack{
                            Text("Страховка")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.top)
                            Spacer()
                            Image(systemName: "doc")
                                .resizable()
                                .frame(width: 32, height: 40)
                                .padding(.bottom)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .sheet(isPresented: $showingActionSheetInsurance) {
                        InsurenceImageView(image: img,
                                           showingActionSheetInsurence: $showingActionSheetInsurance,
                                           carIndex: index,
                                           updateCarsAction: updateCars)
                    }
                }else {
                    Button{
                        withAnimation(.snappy){
                            self.showingEditInsurance = true
                        }
                    } label: {
                        VStack{
                            Text("Страховка")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.top)
                            Spacer()
                            Image(systemName: "doc.badge.plus")
                                .resizable()
                                .frame(width: 42, height: 50)
                                .padding(.bottom)
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .actionSheet(isPresented: $showingEditInsurance) {
                        ActionSheet(title: Text("Выберите действие"), buttons: [
                            .default(Text("Камера"), action: {
                                self.showingImagePickerInsurence = true
                                self.sourceType = .camera
                            }),
                            .default(Text("Галерея"), action: {
                                self.showingImagePickerInsurence = true
                                self.sourceType = .photoLibrary
                            }),
                            .cancel(Text("Отменить"))
                        ])
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePickerSts, onDismiss: loadStsImage){
            ImagePicker(image: self.$selectedImage, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showingImagePickerInsurence, onDismiss: loadInsuranceImage){
            ImagePicker(image: self.$selectedImage, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
        .padding(.bottom)
        
    }
    
    func loadStsImage() {
        guard let selectedImage = selectedImage else { return }
        print("sts")
        HomeCarsModel().updateStsImage(selectedImage, index)
        updateCarsAction()
    }
    func loadInsuranceImage() {
        guard let selectedImage = selectedImage else { return }
        HomeCarsModel().updateInsuranceImage(selectedImage, index)
        updateCarsAction()
    }
    
    func updateCars() {
        updateCarsAction()
    }
    
    /*TODO: - сделать чтобы во время HomeCarsModel().updateInsuranceImage(selectedImage, index) был progressview и кнопка была неактивной
     
    func loadInsuranceImage() {
        guard let selectedImage = selectedImage else { return }
        
        DispatchQueue.global().async {
            HomeCarsModel().updateInsuranceImage(selectedImage, index)
            
            DispatchQueue.main.async {
                updateCarsAction()
            }
        }
    }
     */
}
