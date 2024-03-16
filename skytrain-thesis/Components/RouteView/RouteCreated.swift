//
//  RouteCreated.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct RouteCreated: View {
    @Binding var selectedRoute: [Route]?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            if let selectedRoute = selectedRoute {
                ForEach(selectedRoute) { route in
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                        
                        RouteDetailsCell(route: route)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}
