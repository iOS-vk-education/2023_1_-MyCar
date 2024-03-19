//
//  LocationDetailsView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 13.03.2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    @Binding var getDirections: Bool
    @Binding var distance: String?
    @Binding var travelTime: String?
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                    //line here
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
            .padding(.horizontal)
            .padding(.top)
            
            HStack(){
                VStack(alignment: .leading){
                    Text("Расстояние до точки: " + (distance ?? ""))
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .padding(.trailing)
                    Text("Время в пути: " + (travelTime ?? "net data"))
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .padding(.trailing)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack(){
                VStack(alignment: .leading){
                    Text("Номер телефона:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Button{
                        guard let phoneNumber = mapSelection?.phoneNumber else { return }
                        let telephone = "tel://"
                        let formattedString = telephone + phoneNumber
                        guard let url = URL(string: formattedString) else { return }
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        } else {
                            print("Can't open url on this device")
                        }
                    } label: {
                        Text(mapSelection?.phoneNumber ?? "")
                            .font(.title3)
                            .foregroundStyle(.blue)
                            .padding(.trailing)
                    }
                }
                Spacer()
            }
            .padding()

            
            
            
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
        .onAppear{
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            fetchLookAroundPreview()
            
        }
    }
}

extension LocationDetailsView {
    func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
}
