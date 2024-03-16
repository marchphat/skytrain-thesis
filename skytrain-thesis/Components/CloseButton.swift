//
//  CloseButton.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct CloseButton: View {
    @Binding var currentView: ViewState
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                DispatchQueue.main.async {
                    currentView = .home
                }
            }
        }) {
            switch currentView {
            case .searchFromStation, .searchToStation:
                CircleClostButton()
                
            case .getRoutes:
                CircleClostButton()
                
            default:
                Text("Done")
                    .foregroundColor(Color.blue)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct CircleClostButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(.secondarySystemBackground))
            Image(systemName: "xmark")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(Color(.secondaryLabel))
        }
    }
}
