//
//  StationListView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct StationListView: View {
    @StateObject private var stationViewModel = StationViewModel()
    
    @State private var paddingTop: CGFloat = 429
    @State private var selectedStationLine: StationLine = .all
    
    @Binding var currentView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    @Binding var previousView: ViewState
    
    var body: some View {
        VStack {
            CloseButton(currentView: $currentView)
                .padding(.top, 20)
                .padding(.trailing, 25)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(currentView == .searchStartingStation ? "Starting Station" : "Destination Station")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            StationSearchBar(searchText: $stationViewModel.searchStation)
                .onChange(of: stationViewModel.searchStation) {
                    stationViewModel.filterSelectedStations(selectedLine: selectedStationLine,
                                                            currentView: currentView,
                                                            selectedStarting: selectedStarting,
                                                            selectedDestination: selectedDestination)
                }
            
            StationSearchBarFilter(selectedStationLine: $selectedStationLine)
                .onChange(of: selectedStationLine) {
                    stationViewModel.filterSelectedStations(selectedLine: selectedStationLine,
                                                            currentView: currentView,
                                                            selectedStarting: selectedStarting,
                                                            selectedDestination: selectedDestination)
                }
            
            Divider()
                .padding(.top, 8)
            
            StationSearchList(selectedStation: $stationViewModel.selectedStations,
                              currentView: $currentView,
                              previousView: $previousView,
                              selectedStarting: $selectedStarting,
                              selectedDestination: $selectedDestination)
            
        }
        .padding(.top, paddingTop)
        .background(Color.white)
        .onAppear(perform: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                paddingTop = 0
            }

            stationViewModel.filterSelectedStations(selectedLine: .all,
                                                    currentView: currentView,
                                                    selectedStarting: selectedStarting,
                                                    selectedDestination: selectedDestination)
            
        })
//        .onReceive(Timer.publish(every: 3, on: .main, in: .common).autoconnect()) { _ in
//            stationViewModel.updateArriveTime(stations: stationViewModel.selectedStations)
//        }
        
    }
}
