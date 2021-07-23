//
//  RecentlySearchedStationsRepository.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation

protocol RecentlySearchedStationsRepository {
    var lastEnteredDepartureStation: String? { get set }
    var lastEnteredDestinationStation: String? { get set }
}

class RecentlySearchedStationsRepositoryImpl: RecentlySearchedStationsRepository {
    private let defaults = UserDefaults.standard
    
    let lastEnteredDepartureStationKey = "RecentlySearchedStationsRepository.lastEnteredDepartureStation"
    
    var lastEnteredDepartureStation: String? {
        get {
            defaults.string(forKey: lastEnteredDepartureStationKey)
        }
        set {
            defaults.set(newValue, forKey: lastEnteredDepartureStationKey)
        }
    }
    
    let lastEnteredDestinationStationKey = "RecentlySearchedStationsRepository.lastEnteredDestinationStation"
    
    var lastEnteredDestinationStation: String? {
        get {
            defaults.string(forKey: lastEnteredDestinationStationKey)
        }
        set {
            defaults.set(newValue, forKey: lastEnteredDestinationStationKey)
        }
    }
}

/*
 * Used for testing.
 */
class RecentlySearchedStationsRepositoryDummy: RecentlySearchedStationsRepository {
    var lastEnteredDepartureStation: String?
    var lastEnteredDestinationStation: String?
}
