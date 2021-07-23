//
//  StationDataTrainCodesParser.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import SWXMLHash

protocol StationDataTrainInfosParser {
    func parse(xmlData: Data) throws -> [TrainInfo]
}

class StationDataTrainInfosParserImpl: StationDataTrainInfosParser {
    public static let DEFAULT_TRAIN_TYPE = "Standard"
    public static let GENERIC_TRAIN_TYPES = ["train"]
    
    let xmlParser = SWXMLHash.shared
    
    func parse(xmlData: Data) throws -> [TrainInfo] {
        if xmlData.isEmpty {
            throw RailStationDataError.parsing("Empty data")
        }
        
        var result = [TrainInfo]()
        
        let xml = xmlParser.parse(xmlData)
        let root = xml["ArrayOfObjStationData"]
        
        for element in root.children {
            guard var code = element["Traincode"].valueAsString else {
                throw RailStationDataError.parsing("Invalid code")
            }
            
            var type = element["Traintype"].valueAsString ?? Self.DEFAULT_TRAIN_TYPE
            type = type.lowercased()
            
            if Self.GENERIC_TRAIN_TYPES.contains(type) {
                type = Self.DEFAULT_TRAIN_TYPE
            }
            
            code = code.trimmingCharacters(in: .whitespaces)
            
            result.append(TrainInfo(code: code, kind: type))
        }
        
        return result
    }
}
