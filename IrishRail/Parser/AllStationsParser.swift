//
//  AllStationsParser.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import SWXMLHash

protocol AllStationsParser {
    func parse(xmlData: Data) throws -> [RailStation]
}

class AllStationsParserImpl: AllStationsParser {
    let xmlParser = SWXMLHash.shared
    
    func parse(xmlData: Data) throws -> [RailStation] {
        if xmlData.isEmpty {
            throw RailStationDataError.parsing("Empty data")
        }
        
        var result = [RailStation]()
        
        let xml = xmlParser.parse(xmlData)
        let root = xml["ArrayOfObjStation"]
        
        for element in root.children {
            guard let name = element["StationDesc"].valueAsString else {
                throw RailStationDataError.parsing("Invalid station descriptor")
            }
            
            guard let code = element["StationCode"].valueAsString else {
                throw RailStationDataError.parsing("Invalid station code")
            }
            
            guard let id = element["StationId"].valueAsInt else {
                throw RailStationDataError.parsing("Invalid station id")
            }
            
            var station = RailStation()
            station.name = name.trimmingCharacters(in: .whitespaces)
            station.code = code
            station.id = id
            
            result.append(station)
        }
        
        return result
    }
}
