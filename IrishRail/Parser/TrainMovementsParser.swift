//
//  TrainMovementsParser.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import SWXMLHash

protocol TrainMovementsParser {
    func parse(xmlData: Data) throws -> [RailStationMovement]
}

class TrainMovementsParserImpl: TrainMovementsParser {
    let xmlParser = SWXMLHash.shared
    
    func parse(xmlData: Data) throws -> [RailStationMovement] {
        if xmlData.isEmpty {
            throw RailStationDataError.parsing("Empty data")
        }
        
        var result = [RailStationMovement]()
        
        let xml = xmlParser.parse(xmlData)
        let root = xml["ArrayOfObjTrainMovements"]
        
        var movements = root.children
        
        try movements.sort(by: { a, b in
            let aOrder = a["LocationOrder"].valueAsInt
            let bOrder = b["LocationOrder"].valueAsInt
            
            guard let aOrder = aOrder, let bOrder = bOrder else {
                throw RailStationDataError.parsing("Invalid location order")
            }
            
            return aOrder < bOrder
        })
        
        guard let last = movements.last else {
            throw RailStationDataError.parsing("Empty movements")
        }
        
        let destination = try parseLastStop(last)
        
        // Build all movements (except last one)
        for it in movements.enumerated().dropLast() {
            let element = it.element
            let movement = try parseMovement(element, destination: destination)
            
            result.append(movement)
        }
        
        // Append last to the end
        result.append(RailStationMovement(current: destination, destination: destination))
        
        return result
    }
    
    private func parseLastStop(_ element: XMLIndexer) throws -> RailStationMovement.Stop {
        var lastStop = try parseStop(element)
        
        // Last stop does not have departure
        lastStop.departure = nil
        
        return lastStop
    }
    
    private func parseStop(_ element: XMLIndexer) throws -> RailStationMovement.Stop {
        guard var trainCode = element["TrainCode"].valueAsString else {
            throw RailStationDataError.parsing("Invalid traincode")
        }
        
        trainCode = trainCode.trimmingCharacters(in: .whitespaces)
        
        guard let currentLocationName = element["LocationFullName"].valueAsString else {
            throw RailStationDataError.parsing("Invalid location name")
        }
        
        guard let locationOrder = element["LocationOrder"].valueAsInt else {
            throw RailStationDataError.parsing("Invalid location order")
        }
        
        guard let trainDate = element["TrainDate"].valueAsString else {
            throw RailStationDataError.parsing("Invalid train date")
        }
        
        var arrival = element["ScheduledArrival"].valueAsString ?? ""
        var departure = element["ScheduledDeparture"].valueAsString ?? ""
        
        if !arrival.isEmpty {
            arrival = "\(trainDate) \(arrival)"
        }
        
        if !departure.isEmpty {
            departure = "\(trainDate) \(departure)"
        }
        
        // First stop does not have arrival
        if locationOrder == 1 {
            arrival = ""
        }
        
        var current = RailStationMovement.Stop()
        current.name = currentLocationName
        current.trainCode = trainCode
        current.locationOrder = locationOrder
        current.arrival = RailStationMovement.Stop.format(stringDate: arrival)
        current.departure = RailStationMovement.Stop.format(stringDate: departure)
        
        return current
    }
    
    private func parseMovement(_ element: XMLIndexer, destination: RailStationMovement.Stop) throws -> RailStationMovement {
        let current = try parseStop(element)
        
        if current.locationOrder >= destination.locationOrder {
            throw RailStationDataError.logic("Current location order must be lower than destination's")
        }
        
        return RailStationMovement(current: current, destination: destination)
    }
}
