//
//  Station.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import Foundation
import CoreLocation

struct Station: Codable, Equatable, Identifiable {
    let id = UUID()
    let stationId: String?
    let name: String?
    let latitude: Double
    let longitude: Double
    let line: String?
    let lineColor: String?
    var arriveTime: String?
    let isExtended: Bool
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    enum CodingKeys: CodingKey {
        case stationId
        case name
        case line
        case lineColor
        case isExtended
        case latitude
        case longitude
        case arriveTime
    }
}

enum StationLine: String {
    case all = "all"
    case bts = "bts"
    case mrt = "mrt"
    case arl = "arl"
}
