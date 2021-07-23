//
//  StationSuggestion.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import SwiftUI

struct StationSuggestion: Identifiable, Hashable {
    let value: String
    let displayText: String
    let id: String
    
    init(_ value: String) {
        self.value = value
        self.displayText = value
        self.id = value
    }
    
    init(fromStation station: RailStation) {
        self.value = station.name
        self.displayText = "\(station.name) (\(station.code))"
        self.id = "\(station.id)"
    }
}

protocol StationSuggestionFilter {
    func contains(text: String, in suggestions: [RailStation]) -> Bool
    
    func currentSuggestions(for currentText: String, suggestions: [RailStation]) -> [StationSuggestion]
}

struct StationSuggestionFilterImpl: StationSuggestionFilter {
    func contains(text: String, in suggestions: [RailStation]) -> Bool {
        let currentText = text.lowercased()
        
        return suggestions.map({ value in
            value.name.lowercased()
        }).contains(currentText)
    }
    
    func currentSuggestions(for currentText: String, suggestions: [RailStation]) -> [StationSuggestion] {
        let currentText = currentText.lowercased()
        
        if currentText.count <= 1 {
            return []
        }
        
        let result = suggestions.filter { value in
            let otherValue = value.name.lowercased()
            return otherValue.contains(currentText) && otherValue != currentText
        }.map { value in
            StationSuggestion(fromStation: value)
        }.sorted(by: { $0.displayText < $1.displayText })
        
        return result
    }
}
