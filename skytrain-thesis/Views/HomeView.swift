//
//  HomeView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct HomeView: View {
    @State private var currentView = ViewState.home
    @State private var selectedStarting: Station?
    @State private var selectedDestination: Station?
    @State private var previousView: ViewState = ViewState.home
    @State private var selectedRoute: [Route]?
    @State private var selectedRouteFees: Float = 0
    
    var body: some View {
        ZStack {
//            MapView(previousView: $previousView,
//                    selectedStarting: $selectedStarting,
//                    selectedDestination: $selectedDestination)
            
            GraphicMapView(previousView: $previousView,
                           selectedStarting: $selectedStarting,
                           selectedDestination: $selectedDestination)
                
            switch currentView {
            case .home:
                MapButton(previousView: $previousView)
                
                StationSearchBox(
                    currentView: $currentView,
                    selectedStarting: $selectedStarting,
                    selectedDestination: $selectedDestination
                )
                
            case .searchStartingStation, .searchDestination:
                StationListView(
                    currentView: $currentView,
                    selectedStarting: $selectedStarting,
                    selectedDestination: $selectedDestination,
                    previousView: $previousView
                )
                
            case .getRoutes:
                GetRoutesListView(currentView: $currentView,
                                  selectedStarting:  $selectedStarting,
                                  selectedDestination: $selectedDestination,
                                  selectedRoute: $selectedRoute,
                                  selectedRouteFees: $selectedRouteFees)
                
            case .routeCreated:
                RouteCreatedView(currentView:  $currentView,
                                 selectedStarting: $selectedStarting,
                                 selectedDestination: $selectedDestination,
                                 selectedRoute: $selectedRoute,
                                 selectedRouteFees: $selectedRouteFees)
            }
        }
    }
}

#Preview {
    HomeView()
}

