//
//  StationViewModel.swift
//  skytrain-thesis
//
//  Created by Nantanat Thongthep on 13/3/2567 BE.
//

import Foundation
import Alamofire

final class StationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var searchStation = ""
    @Published var selectedStations = [Station]()
    @Published var allStations = [Station]()
    
    private enum APIError: Error {
        case invalidParameters
        case invalidResponse
    }
    
    // MARK: - Initializer
    init() {
        fetchStations()
    }
    
    // MARK: - Private Methods
    private func fetchStations() {
        let url = "http://127.0.0.1:5214/api/Station"
        
        AF.request(url).validate().responseDecodable(of: [Station].self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let stations):
                self.allStations = stations
                
                //MARK: - Fetch arrival time for each station and update corresponding Station object
                stations.forEach { station in
                    self.fetchArriveTime(for: station.id) { result in
                        switch result {
                        case .success(let arriveTime):
                            DispatchQueue.main.async {
                                var updatedStation = station
                                updatedStation.arriveTime = arriveTime
                                
                                if let index = self.allStations.firstIndex(where: { $0.id == station.id }) {
                                    self.allStations[index] = updatedStation
                                }
                            }
                        case .failure(let error):
                            print("Error fetching arrival time for station \(station.id ?? ""): \(error.localizedDescription)")
                        }
                    }
                }
                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchArriveTime(for stationId: String?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let stationId = stationId else {
            completion(.failure(APIError.invalidParameters))
            return
        }
        
        let url = "http://localhost:5214/api/ArriveTime/\(stationId)"
        
        AF.request(url).validate().response { response in
            guard let data = response.data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            //MARK: - Remove "" from "00:00:00" to 00:00:00
            guard let arriveTime = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "") else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            //MARK: - Convert arrival time to date format
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSSSSSS"
            
            guard let date = formatter.date(from: arriveTime) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            //MARK: - Format date as string in "mm:ss" format
            let minuteSecondFormatter = DateFormatter()
            minuteSecondFormatter.dateFormat = "mm:ss"
            let minuteSecondString = minuteSecondFormatter.string(from: date)
            
            completion(.success(minuteSecondString))
        }
    }

    
    private func isMatched(station: Station, selectedLine: StationLine, currentView: ViewState, selectedFromStation: Station?, selectedToStation: Station?) -> Bool {
        let lineMatch = selectedLine == .all || station.line?.lowercased() == selectedLine.rawValue
        var searchTextMatch = true
        
        if !searchStation.isEmpty {
            let nameMatch = station.name?.localizedCaseInsensitiveContains(searchStation) == true
            let idMatch = station.id?.localizedCaseInsensitiveContains(searchStation) == true
            searchTextMatch = nameMatch || idMatch
        }
        
        switch currentView {
        case .searchFromStation:
            return lineMatch && searchTextMatch && (station.id! != selectedToStation?.id)
        case .searchToStation:
            return lineMatch && searchTextMatch && (station.id! != selectedFromStation?.id)
        default:
            return false
        }
    }
    
    // MARK: - Public Methods
    func filterSelectedStations(selectedLine: StationLine, currentView: ViewState, selectedFromStation: Station?, selectedToStation: Station?) {
        selectedStations = allStations.filter { station in
            return isMatched(station: station,
                             selectedLine: selectedLine,
                             currentView: currentView,
                             selectedFromStation: selectedFromStation,
                             selectedToStation: selectedToStation)
        }
    }
    
    func updateArriveTime(stations: [Station]) {
        stations.forEach { station in
            self.fetchArriveTime(for: station.id) { result in
                switch result {
                case .success(let arriveTime):
                    DispatchQueue.main.async {
                        var updatedStation = station
                        updatedStation.arriveTime = arriveTime
                        
                        if let index = self.selectedStations.firstIndex(where: { $0.id == station.id }) {
                            self.selectedStations[index] = updatedStation
                        }
                    }
                case .failure(let error):
                    print("Error fetching arrival time for station \(station.id ?? ""): \(error.localizedDescription)")
                }
            }
        }
    }
}
