//
//  RailStationsRepository.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation

protocol StationsRepository {
    var stationsPublisher: Published<[RailStation]>.Publisher { get }
    
    func save(newData data: [RailStation])
}

class StationsRepositoryImpl: StationsRepository {
    @Published var stations: [RailStation] = []
    
    private let queue = DispatchQueue.main
    
    var stationsPublisher: Published<[RailStation]>.Publisher {
        return $stations
    }
    
    func save(newData data: [RailStation]) {
        weak var weakSelf = self
        
        // Update safely on the main queue
        queue.async {
            weakSelf?.stations = data
        }
    }
}
