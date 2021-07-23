//
//  AppComponents.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation
import Resolver

class AppComponents {
    public static let shared = AppComponents()
    
    let session: NetworkSession
    
    init() {
        let session = NetworkSessionStandard(session: URLSession.shared)
        self.session = session
        
        Resolver.defaultScope = .application
        
        Resolver.register { session as NetworkSession }
        
        // MARK: Parsers
        Resolver.register { AllStationsParserImpl() as AllStationsParser }
        Resolver.register { StationDataTrainInfosParserImpl() as StationDataTrainInfosParser }
        Resolver.register { TrainMovementsParserImpl() as TrainMovementsParser }
        
        // MARK: Request builders
        Resolver.register { APIAllStationsRequestBuilderImpl() as APIAllStationsRequestBuilder }
        Resolver.register { APIStationScheduleRequestBuilderImpl() as APIStationScheduleRequestBuilder }
        Resolver.register { APITrainMovementsRequestBuilderImpl() as APITrainMovementsRequestBuilder }
        
        // MARK: Network services
        Resolver.register { AllStationsNetworkServiceImpl() as AllStationsNetworkService }
        Resolver.register { StationScheduleTrainCodesNetworkServiceImpl() as StationScheduleTrainCodesNetworkService }
        Resolver.register { TrainMovementsNetworkServiceImpl() as TrainMovementsNetworkService }
        Resolver.register { StationScheduleNetworkServiceImpl() as StationScheduleNetworkService }
        
        // MARK: Repositories
        Resolver.register { StationsRepositoryImpl() as StationsRepository }
        Resolver.register { RecentlySearchedStationsRepositoryImpl() as RecentlySearchedStationsRepository }
        
        // MARK: Notifications
        Resolver.register { NotificationsReminderStorageImpl() as NotificationsReminderStorage }
        Resolver.register { NotificationsReminderManagerImpl() as NotificationsReminderManager }
        
        // MARK: Other
        Resolver.register { StationSuggestionFilterImpl() as StationSuggestionFilter }
        
        // MARK: Init immediately
        let _ = Resolver.resolve(NotificationsReminderManager.self)
    }
}
