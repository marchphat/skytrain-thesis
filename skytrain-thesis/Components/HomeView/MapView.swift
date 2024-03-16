//
//  MapView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private var stationViewModel = StationViewModel()
    @Binding var previousView: ViewState
    @Binding var selectedFromStation: Station?
    @Binding var selectedToStation: Station?
    
    //MARK: - Phaya Thai ARL
    private let defaultStation = CLLocationCoordinate2D(latitude: 13.780825439075091, longitude:  100.54287689074913)
    
    private var region: MKCoordinateRegion {
        let centerCoordinate: CLLocationCoordinate2D?
        switch previousView {
        case .searchFromStation:
            centerCoordinate = selectedFromStation?.coordinate
        case .searchToStation:
            centerCoordinate = selectedToStation?.coordinate
        case .home:
            centerCoordinate = defaultStation
        default:
            centerCoordinate = nil
        }
        
        return MKCoordinateRegion(center: centerCoordinate ?? defaultStation,
                                  span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    var body: some View {
        Map(coordinateRegion: .constant(region),
            annotationItems: stationViewModel.allStations) { station in
            
            MapAnnotation(coordinate: station.coordinate) {
                AnnotationView(station: station)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
