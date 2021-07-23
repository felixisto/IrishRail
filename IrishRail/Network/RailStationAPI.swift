//
//  RailStationAPI.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation

enum RailStationAPIError: Swift.Error {
    case unknown
    case badURL
}

// MARK: All stations
class APIAllStations {
    public static let URLString = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
}

// MARK: Station schedule
class APIStationSchedule {
    // Must be a value between 5 and 90.
    public static let NUM_MINS: Int = 90
    
    // The station name is not case sensitive.
    public static func URLString(stationName: String) -> String {
        let name = stationName.encodedString
        return "https://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=\(name)&NumMins=\(Self.NUM_MINS)"
    }
}

// MARK: Train movements
class APITrainMovements {
    public static var DATE_FORMATTER: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return dateFormatter
    }()
    
    public static func URLString(trainID: String, for date: Date) -> String {
        let date = dateString(fromDate: date)
        return "https://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=\(trainID)&TrainDate=\(date)"
    }
    
    public static func dateString(fromDate date: Date) -> String {
        let formatter = Self.DATE_FORMATTER
        return formatter.string(from: date).lowercased().encodedString
    }
}
