//
//  GraphicMapView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 17/3/2567 BE.
//

import SwiftUI

struct GraphicMap: Identifiable {
    let id: Int
    let name: String
    let position: CGPoint
    let color: Color
}

struct GraphicMapView: View {
    @ObservedObject private var stationViewModel = StationViewModel()
    
    @Binding var previousView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    
    @State private var selectedStation: Station?
    @State private var showingPopup = false
    @State private var scale: CGFloat = 0.5
    
    private let minScale: CGFloat = 0.5
    private let maxScale: CGFloat = 1.3
    private let imageName = "metro-map-th"
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView([.vertical, .horizontal]) {
                ScrollViewReader { scrollViewProxy in
                    ZStack {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 5 * scale)
                            .padding(.bottom, 150)
                            .gesture(MagnificationGesture()
                                .onChanged { value in
                                    let newScale = scale * value.magnitude
                                    if newScale >= minScale && newScale <= maxScale {
                                        scale = newScale
                                    }
                                }
                            )
                        
                        ForEach(stationViewModel.allStations) { station in
                            Button(action: {
                                selectedStation = station
                                showingPopup = true
                            }) {
                                Circle()
                                    .frame(width: max(20 * scale, 18), height: max(20 * scale, 18))
                                    .foregroundColor(Color.red.opacity(0))
                            }
                            .position(x: CGFloat(station.positionX) * geometry.size.width * scale,
                                      y: CGFloat(station.positionY) * geometry.size.width * scale)
                        }
                    }
                    .background(Color(rgb:(246, 246, 246)))
                    .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
                    .onAppear {
                        withAnimation {
                            scrollViewProxy.scrollTo(imageName, anchor: .center)
                        }
                    }
                    .id(imageName)
                }
            }
        }
        .alert(selectedStation?.name ?? "", isPresented: $showingPopup) {
            Button("Starting Station") {
                selectedStarting = selectedStation
                if  selectedDestination == selectedStarting {
                    selectedDestination = nil
                }
            }
            Button("Destination") {
                selectedDestination = selectedStation
                if selectedStarting == selectedDestination {
                    selectedStarting = nil
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            //TODO: - Assign time and distance from station
            Text("3km · Next train 18:45")
        }
    }
}

#Preview {
    HomeView()
}

//private let stations: [GraphicMap] = [
//    GraphicMap(id: 1,
//               name: "RN10 Rangsit",
//               position: CGPoint(x: 2.49, y: 3.46),
//               color: .blue),
//    GraphicMap(id: 2,
//               name: "RN09 Lak Hok",
//               position: CGPoint(x: 2.745, y: 3.46),
//               color: .green),
//    GraphicMap(id: 3,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 3.01, y: 3.46),
//               color: .red),
//    GraphicMap(id: 4,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 3.565, y: 3.46),
//               color: .red),
//    GraphicMap(id: 5,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 4.09, y: 3.46),
//               color: .red),
//    GraphicMap(id: 6,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 4.39, y: 3.46),
//               color: .red),
//    GraphicMap(id: 7,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 4.69, y: 3.46),
//               color: .red),
//    GraphicMap(id: 8,
//               name: "RN08 Don Muang",
//               position: CGPoint(x: 4.775, y: 3.67),
//               color: .red)
//]
