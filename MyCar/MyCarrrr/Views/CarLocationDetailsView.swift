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
    @Binding var getDirections: Bool
    @Binding var selectedCar: CarViewModel?

    
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
            .padding()
            
            if let img = selectedCar?.carImage {
                Image(uiImage: img)
                    .resizable()
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
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
                    getDirections = true
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


