//
//  RailStationRequest.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation

// MARK: All stations
protocol APIAllStationsRequestBuilder {
    func build() throws -> URLRequest
}

class APIAllStationsRequestBuilderImpl: APIAllStationsRequestBuilder {
    func build() throws -> URLRequest {
        guard let url = URL(string: APIAllStations.URLString) else {
            throw RailStationAPIError.badURL
        }
        
        return URLRequest(url: url)
    }
}

// MARK: Station schedule
protocol APIStationScheduleRequestBuilder {
    func build(with stationName: String) throws -> URLRequest
}

class APIStationScheduleRequestBuilderImpl: APIStationScheduleRequestBuilder {
    func build(with stationName: String) throws -> URLRequest {
        guard let url = URL(string: APIStationSchedule.URLString(stationName: stationName)) else {
            throw RailStationAPIError.badURL
        }
        
        return URLRequest(url: url)
    }
}

// MARK: Train movements
protocol APITrainMovementsRequestBuilder {
    func build(with trainID: String, date: Date) throws -> URLRequest
}

class APITrainMovementsRequestBuilderImpl: APITrainMovementsRequestBuilder {
    func build(with trainID: String, date: Date) throws -> URLRequest {
        guard let url = URL(string: APITrainMovements.URLString(trainID: trainID, for: date)) else {
            throw RailStationAPIError.badURL
        }
        
        return URLRequest(url: url)
    }
}

