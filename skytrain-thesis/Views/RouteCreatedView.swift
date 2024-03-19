//
//  SwiftUIView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI
import Drawer

struct RouteCreatedView: View {
    @ObservedObject private var routeViewModel = RouteViewModel()
        
    @State private var isRouteViewShow: Bool = false
    @State private var pointerStraightHeight: CGFloat = 15
    @State private var isLiked = false
    @State private var drawerHeights = drawerDefault
    
    @Binding var currentView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    @Binding var selectedRoute: [Route]?
    @Binding var selectedRouteFees: Float
    
    var body: some View {
        Drawer {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color(.systemBackground))
                    .shadow(radius: 25)
                
                VStack {
                    Capsule()
                        .foregroundColor(Color(.systemGray4))
                        .frame(width: 50, height: 7)
                        .padding(.top, 10)
                        .padding(.bottom, 14)
                    
                    
                    HStack {
                        CloseButton(currentView: $currentView)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(String(format: "฿%.2f", selectedRouteFees))
                        
                        Text("·")
                        
                        Button(action: {
                            self.isLiked.toggle()
                        }) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(isLiked ? .red : .gray)
                                .font(.system(size: 20))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    HStack {
                        Pointer(straightlineHeight: $pointerStraightHeight)
                        
                        VStack {
                            RouteViewHeader(selectedStation: $selectedStarting, stationType: "selectedStarting")
                            
                            RouteViewHeader(selectedStation: $selectedDestination, stationType: "selectedDestination")
                        }
                        .padding(.leading, 5)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical, 4)
                                        
                    RouteCreated(selectedRoute: $selectedRoute)
                    
                    Spacer()
                }
            }
            
        }
        .rest(at: $drawerHeights)
        .ignoresSafeArea()
    }
    
}


