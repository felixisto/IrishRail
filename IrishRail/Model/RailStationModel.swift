//
//  RailStationModel.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation

struct TrainInfo: Identifiable, Hashable {
    typealias Code = String
    typealias Kind = String
    
    var id: String {
        code
    }
    
    var code: Code
    var kind: Kind
}

struct RailStation: Identifiable, Hashable {
    var name: String = ""
    var code: String = ""
    var id: Int = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct RailStationMovement: Identifiable, Hashable {
    struct Stop: Identifiable, Hashable {
        var id: String {
            "\(locationOrder). \(name) \(trainCode)"
        }
        
        var name: String = ""
        var trainCode: TrainInfo.Code = ""
        
        var locationOrder: Int = 0
        
        var arrival: Date?
        var departure: Date?
        
        var arrivalAsString: String? {
            if let date = self.arrival {
                return Self.timeFormatter.string(from: date)
            }
            return nil
        }
        
        var departureAsString: String? {
            if let date = self.departure {
                return Self.timeFormatter.string(from: date)
            }
            return nil
        }
        
        static let timeFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter
        }()
        
        // The given date must be in either of these formats:
        // DD mmm YYYY HH:mm
        // DD mmm YYYY HH:mm:SS
        static func format(stringDate: String) -> Date? {
            // Need multiple formaters, because the API is so inconsistent
            let timeFormatter1: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
                dateFormatter.locale = Locale.current
                return dateFormatter
            }()
            
            let timeFormatter2: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy HH:mm:SS"
                dateFormatter.locale = Locale.current
                return dateFormatter
            }()
            
            return timeFormatter1.date(from: stringDate) ?? timeFormatter2.date(from: stringDate)
        }
    }
    
    var id: String {
        current.id
    }
    
    var current = Stop()
    var destination = Stop()
}

struct RailStationTrainSchedule: Identifiable {
    var id: String {
        movements.first?.id ?? ""
    }
    
    var trainInfo: TrainInfo
    
    var movements: [RailStationMovement] = []
    
    var departure: RailStationMovement.Stop {
        movements.first?.current ?? RailStationMovement.Stop()
    }
    
    var destination: RailStationMovement.Stop {
        movements.last?.current ?? RailStationMovement.Stop()
    }
    
    func subSchedule(fromStart start: String, toDestination destination: String) -> RailStationTrainSchedule {
        var subMovements = [RailStationMovement]()
        
        var startReached = false
        
        for movement in movements {
            let currentName = movement.current.name
            
            if !startReached {
                if currentName == start {
                    startReached = true
                } else {
                    continue
                }
            }
            
            subMovements.append(movement)
            
            if currentName == destination {
                return RailStationTrainSchedule(trainInfo: trainInfo, movements: subMovements)
            }
        }
        
        return RailStationTrainSchedule(trainInfo: trainInfo, movements: [])
    }
}

extension Array where Element == RailStationTrainSchedule {
    func subSchedules(fromStart start: String, toDestination destination: String) -> [RailStationTrainSchedule] {
        var newSchedule = [RailStationTrainSchedule]()
        
        for item in self {
            let newScheduleItem = item.subSchedule(fromStart: start, toDestination: destination)
            
            if !newScheduleItem.movements.isEmpty {
                newSchedule.append(newScheduleItem)
            }
        }
        
        return newSchedule
    }
}

struct RailStationSchedule {
    var schedule: [RailStationTrainSchedule] = []
    
    var isEmpty: Bool {
        schedule.isEmpty
    }
    
    static func buildSorted(schedule: [RailStationTrainSchedule]) -> RailStationSchedule {
        return RailStationSchedule(schedule: schedule).sorted()
    }
    
    func sorted() -> RailStationSchedule {
        RailStationSchedule(schedule: schedule.sorted(by: { a, b in
            guard let dateA = a.departure.arrival, let dateB = b.departure.arrival else {
                return false
            }
            
            return dateA < dateB
        }))
    }
}
