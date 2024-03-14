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
    
    @State private var carSelection: MKMapItem?
    @State private var showCarDetails = false
    
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestionation: MKMapItem?
    
    @State private var carPlaceMark =  MKPlacemark(coordinate: .carLocation)

//TODO: сделать чтобы он скачивал машины каждый раз по onAppear()
//    private let homeCarsModel = HomeCarsModel()
    private var cars = HomeCarsModel().allCars()
    
    @State private var selectedCarIndex = 0
    
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
            
            Annotation(cars.first?.manufacturer ?? "", coordinate: .carLocation) {
                
                ZStack{
                   RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "car.side")
                        .padding(5)
                }
                .onTapGesture {
                    carSelection = MKMapItem(placemark: MKPlacemark(coordinate: .carLocation))
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
            VStack{
                Picker("", selection: $selectedCarIndex) {
                    ForEach(0..<cars.count, id : \.self) {
                        Text(cars[$0].manufacturer)
                    }
                }
            }
            .tint(Color.black)
            .background(Color.gray.opacity(0.5))
            .clipShape(
                .rect(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 12
                )
            )
            
        }
        .overlay(alignment: .trailing){
            VStack{
                Spacer()
                VStack{
                    Button{
                        clearView()
                        carSelection = MKMapItem(placemark: MKPlacemark(coordinate: .carLocation))
                    } label: {
                        Image("signage")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .padding(.vertical)
                    
                    Button{
                        clearView()
                        withAnimation(.snappy){
                            cameraPosition = .region(.userRegion)
                        }
                        searchText = "Автосервис"
                        Task{
                            await searchPlaces()
                        }
                    } label: {
                        Image("car-service")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .padding(.bottom)
                    Button{
                        clearView()
                        withAnimation(.snappy){
                            cameraPosition = .region(.userRegion)
                        }
                        searchText = "Автомойка"
                        Task{
                            await searchPlaces()
                        }
                    } label: {
                        Image("car-wash")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .padding(.bottom)
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
                    .padding(.bottom)
                    
                }
                .padding(.horizontal, 10)
                .background(Color.gray.opacity(0.5))
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )
                
                Spacer()
            }
        }
        .onAppear(){
//            cars = HomeCarsModel().allCars()
        }
        //        .onSubmit(of: .text) {
        //            Task{
        //                await searchPlaces()
        //            }
        //        }
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
        .onChange(of: carSelection, { oldValue, newValue in
            showCarDetails = newValue != nil
            if let selection = carSelection {
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
        .sheet(isPresented: $showCarDetails, content: {
            CarLocationDetailsView(mapSelection: $carSelection, show: $showCarDetails, getDirections: $getDirections)
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
    
    func clearView() {
        withAnimation(.snappy){
            cameraPosition = .region(.userRegion)
            
            searchText = ""
            showDetails = false
            showCarDetails = false
            getDirections = false
            routeDisplaying = false
            
            results = [MKMapItem]()
            mapSelection = nil
            carSelection = nil
            route = nil
            routeDestionation = nil
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
    static var carLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 55.753995, longitude: 37.594069)
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
