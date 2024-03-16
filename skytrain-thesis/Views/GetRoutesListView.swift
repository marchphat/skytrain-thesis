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
    @Binding var selectedFromStation: Station?
    @Binding var selectedToStation: Station?
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
            
            ListViewHeaderWithPointer(selectedFromStation: $selectedFromStation, selectedToStation: $selectedToStation)
            
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
            routeViewModel.fetchRoutes(fromStation: selectedFromStation,
                                       toStation: selectedToStation)
            
            routeViewModel.fetchRouteFees(fromStation: selectedFromStation, toStation: selectedToStation)
                
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                paddingTop = 0
            }
        })
        
    }
}

struct ListViewHeaderWithPointer: View {
    @State private var pointerStraightHeight: CGFloat = 15
    
    @Binding var selectedFromStation: Station?
    @Binding var selectedToStation: Station?

    var body: some View {
        HStack {
            Pointer(straightlineHeight: $pointerStraightHeight)
            
            VStack {
                RouteViewHeader(selectedStation: $selectedFromStation,
                                stationType: "selectedFromStation")
                
                RouteViewHeader(selectedStation: $selectedToStation,
                                stationType: "selectedToStation")
            }
            .padding(.leading, 5)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}

