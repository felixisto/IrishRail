//
//  StationScheduleViewModel.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import Combine
import SwiftUI
import Resolver

class StationScheduleViewModel: ObservableObject {
    let departureStation: String
    let destinationStation: String
    
    @Published var isLoaded = false
    
    @Published var schedule = RailStationSchedule()
    
    @Injected var networkService: StationScheduleNetworkService
    
    private var scheduleScreenIsOpened: Binding<Bool>
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(departureStation: String, destinationStation: String, scheduleScreenIsOpened: Binding<Bool>) {
        self.departureStation = departureStation
        self.destinationStation = destinationStation
        self.scheduleScreenIsOpened = scheduleScreenIsOpened
    }
    
    func refreshData() {
        weak var weakSelf = self
        
        networkService.fetchSchedule(for: departureStation, forDate: Date(), forDestination: destinationStation)
            .receive(on: DispatchQueue.main)
            .sink { result in
            
        } receiveValue: { schedule in
            weakSelf?.schedule = schedule
            weakSelf?.isLoaded = true
        }.store(in: &subscriptions)
    }
}
