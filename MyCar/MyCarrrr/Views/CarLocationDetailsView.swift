//
//  CarLocationDetailsView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 14.03.2024.
//

import SwiftUI
import MapKit

struct CarLocationDetailsView: View {
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @Binding var getCarDirections: Bool
    @Binding var selectedCar: CarViewModel?
    @Binding var distance: String?
    @Binding var travelTime: String?
    
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text(selectedCar?.manufacturer ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(selectedCar?.model ?? "")
                        .font(.footnote)
                        .foregroundStyle(.black)
                        .lineLimit(2)
                        .padding(.trailing)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                    
                }
                
                
                Spacer()
                
                Button{
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
//            .padding()
            .padding(.horizontal)
            .padding(.top)
            
            HStack(){
                VStack(alignment: .leading){
                    Text("Расстояние до авто: " + (distance ?? ""))
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .padding(.trailing)
                    if let travelTime = travelTime {
                        Text("Время в пути: " + travelTime)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    } else {
                        HStack{
                            Text("Время в пути: ")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                                .padding(.trailing)
                            ProgressView()
                        }

                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            if let img = selectedCar?.carImage {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.buttonBorder)
                    .clipped()
            }else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
            
            
            HStack(spacing: 24){
                Button{
                    if let mapSelection {
                        mapSelection.openInMaps()
                    }
                } label: {
                    Text("Open in Maps")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 170, height: 48)
                        .background(.green)
                        .clipShape(.buttonBorder)
                }
                
                Button{
                    getCarDirections = true
                    show = false
                } label: {
                    Text("Get Directions")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 170, height: 48)
                        .background(.blue)
                        .clipShape(.buttonBorder)
                }
            }
            .padding(.horizontal)
            
        }
    }
}


