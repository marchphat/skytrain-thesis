//
//  GetRoutesList.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct GetRoutesList: View {
    @Binding var routeStation: [[Route]]
    @Binding var currentView: ViewState
    @Binding var shortestRoute: [Route]
    @Binding var routeFees: [Float]
    @Binding var cheapestRoute: Float
    @Binding var selectedRoute: [Route]?
    @Binding var selectedRouteFees: Float
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(routeStation.indices, id: \.self) { index in
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedRoute = routeStation[index]
                            selectedRouteFees = routeFees[index]
                            
                            withAnimation(.spring()) {
                                DispatchQueue.main.async {
                                    currentView = .routeCreated
                                }
                            }
                        }
                    
                    switch (routeStation[index].count == shortestRoute.count, routeFees[index] == cheapestRoute) {
                    case (true, true):
                        GetRoutesDetailsCell(routeType: .shortNcheap,
                                             route: routeStation[index],
                                             fees: routeFees[index])
                    case (true, false):
                        GetRoutesDetailsCell(routeType: .shortest,
                                             route: routeStation[index],
                                             fees: routeFees[index])
                    case (false, true):
                        GetRoutesDetailsCell(routeType: .cheapest,
                                             route: routeStation[index],
                                             fees: routeFees[index])
                    case (false, false):
                        GetRoutesDetailsCell(routeType: .general,
                                             route: routeStation[index],
                                             fees: routeFees[index])
                    }
                }
                .padding(.vertical, 8)
                
                Divider()
            }
        }
    }
}
