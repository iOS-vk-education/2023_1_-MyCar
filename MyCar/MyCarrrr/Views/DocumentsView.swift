//
//  DocumentsView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 21.03.2024.
//

import Foundation
import SwiftUI


struct DocumentsView: View {
    
    @State private var cars = [CarViewModel]()
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Документы")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                DrivingLicenseView()
                        .padding()
                    
                    HStack{
                        Text("Документы по автомобилям")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(cars, id: \.id) { car in
                                DocumentsRow(car: car)
                            }
                        }
                        .padding()
                    }
                }
                .onAppear{
                    cars = HomeCarsModel().allCars()
                }
            }
        }
    }
}

struct AddDocumentsImageView: View {
    var body: some View {
        Image(systemName: "eye.slash")
            .resizable()
            .frame(width: 100, height: 100)
    }
}

struct DocumentsImageView: View {
    
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
    }
}

struct DrivingLicenseView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Водительское удостоверение")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            
            NavigationLink(destination: DocumentsImageView(image: UIImage(systemName: "car")!)) {
                HStack{
                    Text("Посмотреть")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Spacer()
                }
                .padding()
                .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                .clipShape(.buttonBorder)
            }
        }

    }
}

struct DocumentsRow: View {
    
    let car: CarViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                Text(car.manufacturer)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.bottom, 6)
            HStack{
                Text("Свидетельсто о регистрации (СТС)")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            
            NavigationLink(destination: DocumentsImageView(image: UIImage(systemName: "car")!)) {
                HStack{
                    Text("Посмотреть")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Spacer()
                }
                .padding()
                .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                .clipShape(.buttonBorder)
            }
            
            HStack{
                Text("Страховой полис")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
            }
            
            if let img = car.insurenceImage {
                NavigationLink(destination: DocumentsImageView(image: img)) {
                    HStack{
                        Text("Посмотреть")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                    .clipShape(.buttonBorder)
                }
            }else {
                NavigationLink(destination: AddDocumentsImageView()) {
                    HStack{
                        Text("Добавить")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0))
                    .clipShape(.buttonBorder)
                }
            }
        }
        .padding(.bottom)
    }
}


#Preview {
    DocumentsView()
}
