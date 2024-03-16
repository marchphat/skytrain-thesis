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
    @Binding var selectedFromStation: Station?
    @Binding var selectedToStation: Station?
    @Binding var previousView: ViewState
    
    var body: some View {
        VStack {
            CloseButton(currentView: $currentView)
                .padding(.top, 20)
                .padding(.trailing, 25)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(currentView == .searchFromStation ? "Starting Station" : "Destination Station")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            StationSearchBar(searchText: $stationViewModel.searchStation)
                .onChange(of: stationViewModel.searchStation) {
                    stationViewModel.filterSelectedStations(selectedLine: selectedStationLine,
                                                            currentView: currentView,
                                                            selectedFromStation: selectedFromStation,
                                                            selectedToStation: selectedToStation)
                }
            
            StationSearchBarFilter(selectedStationLine: $selectedStationLine)
                .onChange(of: selectedStationLine) {
                    stationViewModel.filterSelectedStations(selectedLine: selectedStationLine,
                                                            currentView: currentView,
                                                            selectedFromStation: selectedFromStation,
                                                            selectedToStation: selectedToStation)
                }
            
            Divider()
                .padding(.top, 8)
            
            StationSearchList(selectedStation: $stationViewModel.selectedStations,
                              currentView: $currentView,
                              selectedFromStation: $selectedFromStation,
                              selectedToStation: $selectedToStation, previousView: $previousView)
            
        }
        .padding(.top, paddingTop)
        .background(Color.white)
        .onChange(of: stationViewModel.allStations) { _ in
            stationViewModel.filterSelectedStations(selectedLine: selectedStationLine,
                                                    currentView: currentView,
                                                    selectedFromStation: selectedFromStation,
                                                    selectedToStation: selectedToStation)
        }
        .onAppear(perform: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                paddingTop = 0
            }
        })
//        .onReceive(Timer.publish(every: 3, on: .main, in: .common).autoconnect()) { _ in
//            stationViewModel.updateArriveTime(stations: stationViewModel.selectedStations)
//        }
        
    }
}
