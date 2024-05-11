//
//  StsImageView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.03.2024.
//

import Foundation
import SwiftUI
import SwiftUIImageViewer

struct StsImageView: View {
    
    let model = HomeCarsModel()
    
    @State var image: UIImage
    @Binding var showingActionSheetSts: Bool
    
    @State var showingEditSts = false
    @State var showingImagePickerSts = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    let carIndex: Int
    let updateCarsAction: () -> Void
    
    @State private var showPhoto = false
    
    @Binding var isLoadingStsImage: Bool
    
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
                if isLoadingStsImage {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .foregroundColor(.white)
                        .tint(Color.white)
                        .frame(width: 350, height: 500)
                        .padding(.bottom)
                } else {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 350, height: 500)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .onTapGesture {
                            showPhoto = true
                        }
                }
                
                Spacer()
                
                HStack{
                    
                    Button{
                        showingEditSts = true
                    }label: {
                        Text("Изменить")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
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
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .clipShape(.buttonBorder)
                    
                    Spacer()
                    
                    Button{
                        deleteStsImage()
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
        .sheet(isPresented: $showingImagePickerSts, onDismiss: loadStsImage){
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
    
    func deleteStsImage() {
        
        isLoadingStsImage = true
        showingActionSheetSts = false
        
        DispatchQueue.global().async {
            model.removeStsImage(carIndex)
            DispatchQueue.main.async {
                updateCarsAction()
                isLoadingStsImage = false
            }
        }
    }
    
    func loadStsImage() {
        guard let selectedImage = selectedImage else {
            return
        }

        isLoadingStsImage = true

        DispatchQueue.global().async {
            HomeCarsModel().updateStsImage(selectedImage, carIndex)
            DispatchQueue.main.async {
                updateCarsAction()
                isLoadingStsImage = false
            }
        }
    }
}
