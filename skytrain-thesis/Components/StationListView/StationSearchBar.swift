//
//  StationSearchBar.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct StationSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray.opacity(0.5))
            
            TextField("Search", text: $searchText)
        }
        .frame(height: 40)
        .padding(.horizontal, 35)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 118/255, green: 118/255, blue: 118/254, opacity: 12/100))
                .padding(.horizontal, 20)
        )
    }
}


