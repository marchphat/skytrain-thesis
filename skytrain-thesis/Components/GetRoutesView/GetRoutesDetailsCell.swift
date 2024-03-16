//
//  GetRoutesDetailsCell.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct RouteTypeStyle {
    let text: String
    let color: Color
}

struct GetRoutesDetailsCell: View {
    var routeType: RouteType
    var route: [Route]
    var fees: Float

    private var routeTypeStyle: RouteTypeStyle {
        switch routeType {
        case .shortNcheap:
            return RouteTypeStyle(text: "", color: .orange)
        case .shortest:
            return RouteTypeStyle(text: "Fastest", color: .orange)
        case .cheapest:
            return RouteTypeStyle(text: "Cheapest", color: .green)
        case .general:
            return RouteTypeStyle(text: "General", color: .gray)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if routeType == .shortNcheap {
                    HStack {
                        Text("Fastest")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.orange)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("Cheapest")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                } else {
                    Text(routeTypeStyle.text)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(routeTypeStyle.color)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                HStack {
                    Text("\(route.count) Stations")
                        .font(.body)
                        .lineLimit(1)
                    
                    Text("·")
                    
                    Text(String(format: "฿%.2f", fees))
                    
                }
                
            }
            
            Image(systemName: "chevron.forward")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        
    }
}
