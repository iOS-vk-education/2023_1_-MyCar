//
//  DrivingLicenseView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.03.2024.
//

import Foundation
import SwiftUI

struct DrivingLicenseView: View {
    
    @State private var drivingLicenseImage: UIImage?
    
    @State private var showingActionSheetDrivingLicence = false
    @State private var showingEditDrivingLicence = false
    @State private var showingImagePickerDrivingLicence = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?

    @State private var isLoading = false
    
    let updateCarsAction: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .foregroundStyle(Color.white)
                Text("Водительское удостоверение")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            
            if let img = drivingLicenseImage {
                Button{
                    withAnimation(.snappy){
                        self.showingActionSheetDrivingLicence = true
                    }
                } label: {
                    HStack{
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.white)
                                .tint(Color.white)
                            Text("Loading...")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer()
                        }else {
                            Text("Посмотреть")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                    .clipShape(.buttonBorder)
                }
                .sheet(isPresented: $showingActionSheetDrivingLicence) {
                    DrivingLicenseImageView(image: img,
                                            showingActionSheetDrivingLicence: $showingActionSheetDrivingLicence,
                                            updateCarsAction: updateCars, 
                                            isLoading: $isLoading)
                }
            }else{
                Button{
                    withAnimation(.snappy){
                        self.showingEditDrivingLicence = true
                    }
                } label: {
                    HStack{
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.white)
                                .tint(Color.white)
                            Text("Loading...")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer()
                        }else {
                            Text("Добавить")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                    .clipShape(.buttonBorder)
                }
                .actionSheet(isPresented: $showingEditDrivingLicence) {
                    ActionSheet(title: Text("Выберите действие"), buttons: [
                        .default(Text("Камера"), action: {
                            self.showingImagePickerDrivingLicence = true
                            self.sourceType = .camera
                        }),
                        .default(Text("Галерея"), action: {
                            self.showingImagePickerDrivingLicence = true
                            self.sourceType = .photoLibrary
                        }),
                        .cancel(Text("Отменить"))
                    ])
                }
            }
            
        }.onAppear{
            drivingLicenseImage = HomeDrivingLicenseModel().drivingLicenseImage()
        }
        .sheet(isPresented: $showingImagePickerDrivingLicence, onDismiss: loadDrivingLicenceImage){
            ImagePicker(image: self.$selectedImage, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
        
        
    }
    
    func loadDrivingLicenceImage() {
        guard let selectedImage = selectedImage else { return }

        isLoading = true

        DispatchQueue.global().async {
            HomeDrivingLicenseModel().addDrivingLicense(selectedImage)
            DispatchQueue.main.async {
                updateCars()
                isLoading = false
            }
        }
    }
    
    func updateCars() {
        drivingLicenseImage = HomeDrivingLicenseModel().drivingLicenseImage()
    }
}
