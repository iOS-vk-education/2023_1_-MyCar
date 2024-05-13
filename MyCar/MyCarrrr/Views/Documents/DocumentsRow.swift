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
    
    @State var date: String?

    @State var isLoadingStsImage = false
    @State var isLoadingInsurenceImage = false
    
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
                            if isLoadingStsImage {
                                Text("Loading...")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }else {
                                Text("СТС")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                            Spacer()
                            if isLoadingStsImage {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.5)
                                    .foregroundColor(.white)
                                    .tint(Color.white)
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                            } else {
                                Image(uiImage: UIImage(named: "doc64")!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .disabled(isLoadingStsImage)
                    .sheet(isPresented: $showingActionSheetSts) {
                        StsImageView(image: img, 
                                     showingActionSheetSts: $showingActionSheetSts,
                                     carIndex: index,
                                     updateCarsAction: updateCars,
                                     isLoadingStsImage: $isLoadingStsImage)
                    }
                }else {
                    Button{
                        withAnimation(.snappy){
                            self.showingEditSts = true
                        }
                    } label: {
                        VStack{
                            if isLoadingStsImage {
                                Text("Loading...")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }else {
                                Text("СТС")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                            Spacer()
                            if isLoadingStsImage {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.5)
                                    .foregroundColor(.white)
                                    .tint(Color.white)
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                            } else {
//                                Image(systemName: "doc.badge.plus")
                                Image(uiImage: UIImage(named: "adddoc")!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                                    .padding(.leading)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .disabled(isLoadingStsImage)
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
                            if isLoadingInsurenceImage {
                                Text("Loading...")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }else {
                                Text("Страховка")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                            Spacer()
                            if isLoadingInsurenceImage {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.5)
                                    .foregroundColor(.white)
                                    .tint(Color.white)
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                            } else {
//                                Image(systemName: "doc")
                                Image(uiImage: UIImage(named: "doc64")!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .disabled(isLoadingInsurenceImage)
                    .sheet(isPresented: $showingActionSheetInsurance) {
                        InsurenceImageView(image: img,
                                           showingActionSheetInsurence: $showingActionSheetInsurance,
                                           selectedDate: convertDate(),
                                           carIndex: index,
                                           updateCarsAction: updateCars, 
                                           isLoadingInsurenceImage: $isLoadingInsurenceImage)
                    }
                }else {
                    Button{
                        withAnimation(.snappy){
                            self.showingEditInsurance = true
                        }
                    } label: {
                        VStack{
                            if isLoadingInsurenceImage {
                                Text("Loading...")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }else {
                                Text("Страховка")
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                            Spacer()
                            if isLoadingInsurenceImage {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.5)
                                    .foregroundColor(.white)
                                    .tint(Color.white)
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                            } else {
//                                Image(systemName: "doc.badge.plus")
                                Image(uiImage: UIImage(named: "adddoc")!)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.bottom)
                                    .padding(.leading)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .frame(width: 175, height: 120)
                        .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                        .clipShape(.buttonBorder)
                    }
                    .disabled(isLoadingInsurenceImage)
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

    
    func updateCars() {
        updateCarsAction()
    }
    
    func convertDate () -> Date {
        if let dateString = car.insurenceDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date = dateFormatter.date(from: dateString){
                return date
            }
        }
        return Date()
    }
     
    func loadInsuranceImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        isLoadingInsurenceImage = true
        DispatchQueue.global().async {
            HomeCarsModel().updateInsuranceImage(selectedImage, index)
            DispatchQueue.main.async {
                updateCarsAction()
                isLoadingInsurenceImage = false
            }
        }
    }
    
    func loadStsImage() {
        guard let selectedImage = selectedImage else { return }

        isLoadingStsImage = true

        DispatchQueue.global().async {
            HomeCarsModel().updateStsImage(selectedImage, index)
            DispatchQueue.main.async {
                updateCarsAction()
                isLoadingStsImage = false
            }
        }
    }
     
}
