//
//  RailStationNetworkService.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation
import Combine
import Resolver

// MARK: All stations

/*
 * Fetches general info about all available rail stations.
 */
protocol AllStationsNetworkService {
    func fetchAllStations() -> AnyPublisher<[RailStation], Error>
}

class AllStationsNetworkServiceImpl: AllStationsNetworkService {
    @Injected var session: NetworkSession
    @Injected var requestBuilder: APIAllStationsRequestBuilder
    @Injected var parser: AllStationsParser
    
    func fetchAllStations() -> AnyPublisher<[RailStation], Error> {
        do {
            let request = try requestBuilder.build()
            let parser = self.parser
            
            return session.dataTaskPublisher(forRequest: request)
                .tryMap({ (data: Data, response: URLResponse) in
                    try parser.parse(xmlData: data)
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: Station schedule

/*
 * Fetches all the train ids found in the specified rail station schedule.
 *
 * Train ids can be used to fetch train movements.
 */
protocol StationScheduleTrainCodesNetworkService {
    func fetchScheduledTrainInfos(for stationName: String) -> AnyPublisher<[TrainInfo], Error>
}

class StationScheduleTrainCodesNetworkServiceImpl: StationScheduleTrainCodesNetworkService {
    @Injected var session: NetworkSession
    @Injected var requestBuilder: APIStationScheduleRequestBuilder
    @Injected var parser: StationDataTrainInfosParser
    
    func fetchScheduledTrainInfos(for stationName: String) -> AnyPublisher<[TrainInfo], Error> {
        do {
            let request = try requestBuilder.build(with: stationName)
            let parser = self.parser
            
            return session.dataTaskPublisher(forRequest: request)
                .tryMap({ (data: Data, response: URLResponse) in
                    try parser.parse(xmlData: data)
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: Train movements

/*
 * Fetches all the movements for a train id, for the specified date.
 */
protocol TrainMovementsNetworkService {
    func fetchTrainMovements(trainID: String, for date: Date) -> AnyPublisher<[RailStationMovement], Error>
}

class TrainMovementsNetworkServiceImpl: TrainMovementsNetworkService {
    @Injected var session: NetworkSession
    @Injected var requestBuilder: APITrainMovementsRequestBuilder
    @Injected var parser: TrainMovementsParser
    
    func fetchTrainMovements(trainID: String, for date: Date) -> AnyPublisher<[RailStationMovement], Error> {
        do {
            let request = try requestBuilder.build(with: trainID, date: date)
            let parser = self.parser
            
            return session.dataTaskPublisher(forRequest: request)
                .tryMap({ (data: Data, response: URLResponse) in
                    try parser.parse(xmlData: data)
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: Station schedule

/*
 * Fetches all the train movements for a station.
 */
protocol StationScheduleNetworkService {
    func fetchSchedule(for stationName: String, forDate date: Date, forDestination destination: String) -> AnyPublisher<RailStationSchedule, Error>
}

class StationScheduleNetworkServiceImpl: StationScheduleNetworkService {
    @Injected var stationTrainCodesService: StationScheduleTrainCodesNetworkService
    @Injected var trainMovementsService: TrainMovementsNetworkService
    
    func fetchSchedule(for stationName: String, forDate date: Date, forDestination destination: String) -> AnyPublisher<RailStationSchedule, Error> {
        let stationTrainCodesService = self.stationTrainCodesService
        let trainMovementsService = self.trainMovementsService
        
        return stationTrainCodesService.fetchScheduledTrainInfos(for: stationName)
            .flatMap { trainInfos -> AnyPublisher<RailStationTrainSchedule, Error> in
                var publishers = [AnyPublisher<RailStationTrainSchedule, Error>]()
                
                for info in trainInfos {
                    let publisher = trainMovementsService.fetchTrainMovements(trainID: info.code, for: date).map { movements in
                        RailStationTrainSchedule(trainInfo: info, movements: movements)
                    }.eraseToAnyPublisher()
                    publishers.append(publisher)
                }
                
                return Publishers.MergeMany(publishers).eraseToAnyPublisher()
            }
            .collect()
            .map { schedule in
                let scheduleFiltered = schedule.subSchedules(fromStart: stationName, toDestination: destination)
                return RailStationSchedule.buildSorted(schedule: scheduleFiltered)
            }
            .eraseToAnyPublisher()
    }
}
