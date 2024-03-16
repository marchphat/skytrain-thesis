//
//  RouteViewModel.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import Foundation
import Alamofire

final class RouteViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var allRoutes = [[Route]]()
    @Published var shortestRoute = [Route]()
    @Published var allRouteFees = [Float]()
    @Published var cheapestRoute: Float = 0
    
    // MARK: - Public Methods
    func fetchRouteFees(fromStation: Station?, toStation: Station?) {
        guard let fromStation = fromStation, let toStation = toStation else {
            print("Station is nil value.")
            return
        }
        
        let url = "http://localhost:5214/api/Route/fees/\(fromStation.stationId!)-\(toStation.stationId!)"
        
        AF.request(url).validate().responseDecodable(of: [Float].self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let routes):
                self.allRouteFees = routes
                self.cheapestRoute = self.allRouteFees.min { $0 < $1 }!
                                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchRoutes(fromStation: Station?, toStation: Station?) {
        guard let fromStation = fromStation, let toStation = toStation else {
            print("Station is nil value.")
            return
        }
        
        let url = "http://localhost:5214/api/Route/\(fromStation.stationId!)-\(toStation.stationId!)"
        
        AF.request(url).validate().responseDecodable(of: [[Route]].self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let routes):
                self.allRoutes = routes
                self.shortestRoute = self.allRoutes.min { $0.count < $1.count }!
                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
}
