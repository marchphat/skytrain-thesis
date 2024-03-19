//
//  AnnotationView.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import SwiftUI

struct AnnotationView: View {
    @State private var imageName = "questionmark-pin"
    let station: Station

    var body: some View {
        VStack {
            StationIcon(imageName: imageName)
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(Color(.systemBackground))
                .offset(x: 0, y: -5)

            StationName(station: station)
        }
        .compositingGroup()
        .onAppear {
            switch station.line {
            case "bts":
                imageName = "bts-green-pin"
            case "mrt":
                imageName = "mrt-pin"
            case "arl":
                imageName = "arl-pin"
            default:
                imageName = "questionmark-pin"
            }
        }
    }
}

struct StationIcon: View {
    let imageName: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.systemBackground))
                .frame(width: 50, height: 50)

            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
    }
}

struct StationName: View {
    let station: Station

    var body: some View {
        let id = station.stationId ?? ""
        let name = station.name ?? ""

        Text("\(id) \(name)")
            .font(.caption)
            .foregroundColor(Color(.black))
            .padding(.horizontal, 4)
            .background(Color.white)
            .cornerRadius(4)
    }
}
