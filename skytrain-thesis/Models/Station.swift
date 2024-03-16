//
//  Station.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import Foundation
import CoreLocation

struct Station: Decodable, Equatable, Identifiable {
    let id: String?
    let name: String?
    let line: String?
    let lineColor: String?
    let isExtended: Bool
    let latitude: Double
    let longitude: Double
    var arriveTime: String?
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "station_id"
        case name = "station_name"
        case line = "station_line"
        case lineColor = "station_linecolor"
        case isExtended = "is_extended"
        case latitude = "latitude"
        case longitude = "longitude"
        case arriveTime = "arriveTime"
    }
}

enum StationLine: String {
    case all = "all"
    case bts = "bts"
    case mrt = "mrt"
    case arl = "arl"
}
