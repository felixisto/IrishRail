//
//  RailStationDataParsing.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation

enum RailStationDataError: Error {
    case parsing(String)
    case logic(String)
}
