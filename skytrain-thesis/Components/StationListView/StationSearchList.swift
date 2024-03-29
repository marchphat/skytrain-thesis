//
//  StationSearchList.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 15/3/2567 BE.
//

import SwiftUI

struct StationSearchList: View {
    @Binding var selectedStation: [Station]
    @Binding var currentView: ViewState
    @Binding var previousView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(selectedStation) { station in
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            switch currentView {
                            case .searchStartingStation:
                                selectedStarting = station
                                previousView = .searchStartingStation
                            case .searchDestination:
                                selectedDestination = station
                                previousView = .searchDestination
                            default:
                                print("DEBUG: This view state is not for searching station.")
                            }

                            withAnimation(.spring()) {
                                DispatchQueue.main.async {
                                    currentView = .home
                                }
                            }
                        }
                    
                    StationDetailsCell(station: station)
                }
                .padding(.top, 8)
                
                Divider().padding(.horizontal, 20)
            }
        }
    }
}
