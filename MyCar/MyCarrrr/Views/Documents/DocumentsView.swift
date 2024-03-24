//
//  DocumentsView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 21.03.2024.
//

import Foundation
import SwiftUI
import UIKit


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
                    
                    DrivingLicenseView(updateCarsAction: updateCars)
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
                            ForEach(Array(cars.enumerated()), id: \.element.id) { index, car in
                                DocumentsRow(index: index,
                                             car: car,
                                             updateCarsAction: updateCars)
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
    func updateCars () {
        cars = HomeCarsModel().allCars()
    }
}
