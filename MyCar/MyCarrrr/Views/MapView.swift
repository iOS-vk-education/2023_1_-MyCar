//
//  MapView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 13.03.2024.
//

import MapKit
import SwiftUI
import CoreLocation

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestionation: MKMapItem?
    
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            Annotation("My Location", coordinate: .userLocation) {
                
                ZStack{
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blue.opacity(0.25))
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.blue)
                }
            }
            
            ForEach(results, id: \.self) { item in
                if routeDisplaying {
                    if item == routeDestionation {
                        let placemark = item.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                }else {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            }
            
            
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 6)
            }
        }
        .overlay(alignment: .top){
            HStack{
                TextField("Search for a location...", text: $searchText)
                    .font(.subheadline)
                    .padding(12)
                    .background(.white)
                    .padding()
                    .shadow(radius: 10)
                Button{
                    
                    withAnimation(.snappy){
                        cameraPosition = .region(.userRegion)
                        
                        searchText = ""
                        showDetails = false
                        getDirections = false
                        routeDisplaying = false
                        
                        results = [MKMapItem]()
                        mapSelection = nil
                        route = nil
                        routeDestionation = nil
                    }
                    
                    
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }

        }
        .onSubmit(of: .text) {
            Task{
                await searchPlaces()
            }
        }
        .onChange(of: getDirections, { oldValue, newValue in
            if newValue {
                fetchRoute()
            }
        })
        .onChange(of: mapSelection, { oldValue, newValue in
            showDetails = newValue != nil
            if let selection = mapSelection {
                withAnimation(.snappy){
                    cameraPosition = .item(selection)
                }
            }
        })
        .sheet(isPresented: $showDetails, content: {
            LocationDetailsView(mapSelection: $mapSelection, show: $showDetails, getDirections: $getDirections)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
        .mapControls{
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

extension MapView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
    
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestionation = mapSelection
                
                withAnimation(.snappy){
                    routeDisplaying = true
                    showDetails = false
                    
                    if let rect = route?.polyline.boundingMapRect, routeDisplaying{
                        cameraPosition = .rect(rect)
                    }
                }
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        let locationManager = CLLocationManager()
        guard locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways else {
            return CLLocationCoordinate2D(latitude: 55.753995, longitude: 37.614069) // Пользователь не дал доступ к местоположению
        }
        guard let userLocation = locationManager.location?.coordinate else {
            return CLLocationCoordinate2D(latitude: 55.753995, longitude: 37.614069) // Невозможно получить текущее местоположение пользователя
        }
        return userLocation
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

#Preview {
    MapView()
}
