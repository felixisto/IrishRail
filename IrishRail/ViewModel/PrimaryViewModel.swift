//
//  PrimaryViewModel.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import Combine
import Resolver

class PrimaryViewModel: ObservableObject {
    @Published var departureValue: String = ""
    @Published var destinationValue: String = ""
    @Published var stationSuggestions: [RailStation] = []
    
    @Published var scheduleScreenIsOpened: Bool = false {
        didSet {
            recentlySearchedRepo.lastEnteredDepartureStation = departureValue
            recentlySearchedRepo.lastEnteredDestinationStation = destinationValue
        }
    }
    
    @Injected var repository: StationsRepository
    @Injected var networkService: AllStationsNetworkService
    @Injected var suggestionFilter: StationSuggestionFilter
    @Injected var recentlySearchedRepo: RecentlySearchedStationsRepository
    
    var canProceed: Bool {
        suggestionFilter.contains(text: departureValue, in: stationSuggestions) &&
            suggestionFilter.contains(text: destinationValue, in: stationSuggestions) &&
        departureValue != destinationValue
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        repository.stationsPublisher.receive(on: DispatchQueue.main).assign(to: &$stationSuggestions)
        
        if let string = recentlySearchedRepo.lastEnteredDepartureStation {
            departureValue = string
        }
        
        if let string = recentlySearchedRepo.lastEnteredDestinationStation {
            destinationValue = string
        }
    }
    
    func refreshData() {
        if !stationSuggestions.isEmpty {
            return
        }
        
        print(String(describing: Self.self) + "| Refresh data...")
        
        weak var weakSelf = self
        
        networkService.fetchAllStations().receive(on: DispatchQueue.main).sink { result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                weakSelf?.handleRefreshError(error)
                break
            }
        } receiveValue: { newData in
            weakSelf?.handleRefresh(data: newData)
        }.store(in: &subscriptions)
    }
    
    private func handleRefresh(data: [RailStation]) {
        print(String(describing: Self.self) + "| Saving new data to repo (\(data.count) stations)")
        
        repository.save(newData: data)
    }
    
    private func handleRefreshError(_ error: Error) {
        print(String(describing: Self.self) + "| Refresh error: \(error)")
    }
}
