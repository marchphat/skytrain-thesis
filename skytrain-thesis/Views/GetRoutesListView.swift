//
//  GetRoutesListView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct GetRoutesListView: View {
    @ObservedObject private var routeViewModel = RouteViewModel()
    
    @State private var paddingTop: CGFloat = 429
    
    @Binding var currentView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    @Binding var selectedRoute: [Route]?
    @Binding var selectedRouteFees: Float
    
    var body: some View {
        VStack {
            CloseButton(currentView: $currentView)
                .padding(.top, 20)
                .padding(.trailing, 25)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            Text("Routes")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ListViewHeaderWithPointer(selectedStarting: $selectedStarting, selectedDestination: $selectedDestination)
            
            Divider()
                .padding(.top, 8)
            
            GetRoutesList(routeStation: $routeViewModel.allRoutes,
                          currentView: $currentView,
                          shortestRoute: $routeViewModel.shortestRoute,
                          routeFees: $routeViewModel.allRouteFees,
                          cheapestRoute: $routeViewModel.cheapestRoute,
                          selectedRoute: $selectedRoute,
                          selectedRouteFees: $selectedRouteFees)
            
        }
        .padding(.top, paddingTop)
        .background(Color.white)
        .onAppear(perform: {
            routeViewModel.fetchRoutes(fromStation: selectedStarting,
                                       toStation: selectedDestination)
            
            routeViewModel.fetchRouteFees(fromStation: selectedStarting, toStation: selectedDestination)
                
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                paddingTop = 0
            }
        })
        
    }
}

struct ListViewHeaderWithPointer: View {
    @State private var pointerStraightHeight: CGFloat = 15
    
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?

    var body: some View {
        HStack {
            Pointer(straightlineHeight: $pointerStraightHeight)
            
            VStack {
                RouteViewHeader(selectedStation: $selectedStarting,
                                stationType: "selectedStarting")
                
                RouteViewHeader(selectedStation: $selectedDestination,
                                stationType: "selectedDestination")
            }
            .padding(.leading, 5)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}

