//
//  DocumentsImageView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 23.03.2024.
//

import Foundation
import SwiftUI
import SwiftUIImageViewer


struct DrivingLicenseImageView: View {
    
    let model = HomeDrivingLicenseModel()
    
    @State var image: UIImage
    @Binding var showingActionSheetDrivingLicence: Bool
    
    @State var showingEditDrivingLicence = false
    @State var showingImagePickerDrivingLicence = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    let updateCarsAction: () -> Void
    
    @State private var showPhoto = false
    
    var closeButton: some View {
        Button {
            showPhoto = false
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
        .buttonStyle(.bordered)
        .clipShape(Circle())
        .tint(.gray)
        .padding()
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea(.all)
                .foregroundStyle(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
            VStack{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 350, height: 500)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .onTapGesture {
                        showPhoto = true
                    }
                
                Spacer()
                
                HStack{
                    
                    Button{
                        showingEditDrivingLicence = true
                    }label: {
                        Text("Изменить")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
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
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .clipShape(.buttonBorder)
                    
                    Spacer()
                    
                    Button{
                        model.remove()
                        showingActionSheetDrivingLicence = false
                        updateCarsAction()
                    }label: {
                        Text("Удалить")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.red)
                    .clipShape(.buttonBorder)
                }
                .padding()

                
            }
            .padding()
            
        }
        .sheet(isPresented: $showingImagePickerDrivingLicence, onDismiss: loadDrivingLicenceImage){
            ImagePicker(image: self.$selectedImage, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showPhoto){
            SwiftUIImageViewer(image: Image(uiImage: image))
                .overlay(alignment: .topTrailing) {
                    closeButton
                }
                .background(Color.black)
        }
    }
    
    func loadDrivingLicenceImage() {
        guard let selectedImage = selectedImage else { return }
        withAnimation(.snappy){
            image = selectedImage
        }
        //TODO: - сделать асинхрон
        model.changeDrivingLicenseImage(selectedImage)
        updateCarsAction()
    }

}





