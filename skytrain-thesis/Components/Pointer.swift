//
//  Pointer.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct Pointer: View {
    @Binding var straightlineHeight: CGFloat
    
    var body: some View {
        VStack{
            Circle()
                .fill(Color.blue)
                .frame(width: 8, height: 8)
                .shadow(
                    color: .black.opacity(0.29),
                    radius: 4,x: 0, y: 4
                )
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 2, height: straightlineHeight)
                .shadow(
                    color: .black.opacity(0.29),
                    radius: 4,x: 0, y: 4
                )
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 8, height: 8)
                .shadow(
                    color: .black.opacity(0.29),
                    radius: 4,x: 0, y: 4
                )
        }
    }
}

