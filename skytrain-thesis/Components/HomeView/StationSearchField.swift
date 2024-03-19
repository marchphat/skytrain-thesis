//
//  StationSearchField.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct StationSearchField: View {
    @Binding var selectedStation: Station?
    @Binding var inputType: String
    
    private var textField: String {
        switch inputType {
        case "From":
            return selectedStation?.name ?? "Starting Station"
        case "To":
            return selectedStation?.name ?? "Destination"
        default:
            return ""
        }
    }
    
    var body: some View {
        VStack (spacing: 10) {
            HStack{
                Text(inputType == "From" ? "From" : "To")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .frame(width: 40, alignment: .leading)
                
                Text(textField)
                    .font(.system(size: 16))
                    .foregroundColor(selectedStation?.name == nil ? Color.gray.opacity(0.5) : Color.black)
                    .fontWeight(.medium)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 4,x: 0, y: 4
                    )
            )
        }
    }
}
