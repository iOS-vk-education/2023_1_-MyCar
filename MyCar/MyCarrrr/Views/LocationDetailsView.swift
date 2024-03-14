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
                //TODO: Error Failed to open URL tel://111-11-11: Error Domain=NSOSStatusErrorDomain Code=-10814 "(null)" UserInfo={_LSLine=277, _LSFunction=-[_LSDOpenClient openURL:fileHandle:options:completionHandler:]}
                    Button{
//                        guard let phoneNumber = mapSelection?.phoneNumber else { return }
                        let telephone = "tel://"
                        let phoneNumber = "111-11-11"
                        let formattedString = telephone + phoneNumber
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Text(mapSelection?.phoneNumber ?? "")
                            .font(.title3)
                            .foregroundStyle(.blue)
                            .padding(.trailing)
                    }
                    
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
            
            
            
//            if let scene = lookAroundScene {
//                LookAroundPreview(initialScene: scene)
//                    .frame(height: 200)
//                    .clipShape(.buttonBorder)
//                    .padding()
//            }else {
//                ContentUnavailableView("No preview available", systemImage: "eye.slash")
//            }
            
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
