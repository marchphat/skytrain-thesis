//
//  RouteViewHeader.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct RouteViewHeader: View {
    @Binding var selectedStation: Station?
    var stationType: String
    
    private var textColor: Color {
        switch stationType {
        case "selectedStarting":
            return Color.gray
        case "selectedDestination":
            return Color.blue
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        HStack {
            Text(selectedStation?.name ?? "Station not found.")
                .font(.system(size: 16))
                .foregroundColor(textColor)
                .frame(height: 30)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text((selectedStation?.arriveTime) ?? "Closed")
                .foregroundColor(textColor)
                .frame(height: 30)
        }
    }
}
