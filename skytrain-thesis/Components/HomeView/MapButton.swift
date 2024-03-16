//
//  MapButton.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct MapButton: View {
    @Binding var previousView: ViewState
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: 40, height: 100)
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 4, x: 0, y: 4
                    )
                
                VStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "bookmark.fill")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                            .frame(width: 30, height: 30)
                    }
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 40, height: 1.5)
                    
                    Button(action: {
                        previousView = .home
                    }) {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
        .padding(.top, 30)
    }
}

