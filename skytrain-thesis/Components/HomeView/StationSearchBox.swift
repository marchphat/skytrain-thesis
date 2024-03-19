//
//  StationSearchBox.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct StationSearchBox: View {
    @State private var paddingBottom: CGFloat = 20
    @State private var isShowingStationListView: Bool = false
    @State private var pointerStraightHeight: CGFloat = 33
    @State private var fromText = "From"
    @State private var toText = "To"
    
    @Binding var currentView: ViewState
    @Binding var selectedStarting: Station?
    @Binding var selectedDestination: Station?
    
    private var isInputCompleted: Bool  {
        return selectedStarting == nil || selectedDestination == nil
    }
    
    var body: some View {
        VStack {
            HStack{
                Pointer(straightlineHeight: $pointerStraightHeight)
                
                
                VStack (spacing: 10) {
                    StationSearchField(selectedStation: $selectedStarting, inputType: $fromText)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                currentView = .searchStartingStation
                            }
                        }
                    
                    StationSearchField(selectedStation: $selectedDestination, inputType: $toText)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                currentView = .searchDestination
                            }
                        }
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal)
            
            
            //MARK: - Switching View Button
    
            Button(action: {
                currentView = .getRoutes
            }) {
                Text("Get routes")
                    .foregroundColor(isInputCompleted ? Color.blue : Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(isInputCompleted ? Color(red: 235/255, green: 235/255, blue: 235/255) : Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                    .shadow(
                        color: .black.opacity(0.29),
                        radius: 4, x: 0, y: 4
                    )
            }
            .disabled(isInputCompleted)
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .onAppear(perform: {
            withAnimation(.default) {
                paddingBottom = 40
            }
        })
        .padding(.horizontal)
        .padding(.bottom, paddingBottom)
    }
    
}
