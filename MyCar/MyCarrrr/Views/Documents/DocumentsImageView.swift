//
//  DocumentsImageView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 23.03.2024.
//

import Foundation
import SwiftUI


struct StsImageView: View {
    
    let model = HomeCarsModel()
    
    @State var image: UIImage
    @Binding var showingActionSheetSts: Bool
    @Binding var showingEditSts: Bool
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
                        withAnimation(.snappy){
                            showingActionSheetSts = false
                        }
                    }label: {
                        Text("Изменить")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.black)
                    .clipShape(.buttonBorder)
                    
                    Spacer()
                    
                    Button{
                        model.removeStsImage(carIndex)
                        showingActionSheetSts = false
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
    }
}

struct InsurenceImageView: View {
    
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
    }
}

struct DrivingLicenseImageView: View {
    
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
    }
}




