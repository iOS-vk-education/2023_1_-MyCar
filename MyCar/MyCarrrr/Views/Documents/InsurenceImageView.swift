//
//  InsurenceImageView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 24.03.2024.
//

import Foundation
import SwiftUI

struct InsurenceImageView: View {
    
    let model = HomeCarsModel()
    
    @State var image: UIImage
    @Binding var showingActionSheetInsurence: Bool
    
    @State var showingEditInsurence = false
    @State var showingImagePickerInsurence = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    let carIndex: Int
    let updateCarsAction: () -> Void

    
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
                
                Spacer()
                
                HStack{
                    
                    Button{
                        showingEditInsurence = true
                    }label: {
                        Text("Изменить")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                    .actionSheet(isPresented: $showingEditInsurence) {
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
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .clipShape(.buttonBorder)
                    
                    Spacer()
                    
                    Button{
                        model.removeInsureanceImage(carIndex)
                        showingActionSheetInsurence = false
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
        .sheet(isPresented: $showingImagePickerInsurence, onDismiss: loadInsurenceImage){
            ImagePicker(image: self.$selectedImage, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
    }
    func loadInsurenceImage () {
        guard let selectedImage = selectedImage else { return }
        withAnimation(.snappy){
            image = selectedImage
        }
        //TODO: - сделать асинхрон
        HomeCarsModel().updateInsuranceImage(selectedImage, carIndex)
        updateCarsAction()
    }
}