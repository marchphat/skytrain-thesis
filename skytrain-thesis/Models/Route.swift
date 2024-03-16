//
//  Route.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import Foundation

struct Route: Codable, Identifiable {
    let id: String?
    let name: String?
    let line: String?
    let lineColor: String?
    let isExtended: Bool
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "StationId"
        case name = "StationName"
        case line = "StationLine"
        case lineColor = "StationLineColor"
        case isExtended = "IsExtended"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

enum RouteType {
    case shortNcheap
    case shortest
    case cheapest
    case general
}

