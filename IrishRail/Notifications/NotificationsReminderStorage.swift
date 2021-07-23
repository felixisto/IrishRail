//
//  NotificationsReminderStorage.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation

protocol NotificationsReminderStorage {
    var allReminders: [NotificationReminder] { get }
    
    func isReminderScheduled(forSchedule schedule: RailStationTrainSchedule) -> Bool
    func saveReminder(forSchedule schedule: RailStationTrainSchedule) -> NotificationReminder?
    func deleteReminder(forSchedule schedule: RailStationTrainSchedule) -> NotificationReminder?
    
    func deleteExpiredReminders()
}

class NotificationsReminderStorageImpl: NotificationsReminderStorage {
    public static let MIN_EXPECTED_EXPIRATION_TIME: TimeInterval = 30
    
    private let defaults = UserDefaults.standard
    
    private let key = "NotificationsReminderStorage.reminders"
    
    private let queue = DispatchQueue(label: "NotificationsReminderStorage.queue")
    
    var allReminders: [NotificationReminder] {
        queue.sync {
            reminders
        }
    }
    
    init() {
        print(String(describing: Self.self) + "| Initialized with \(allReminders.count) reminders")
    }
    
    func isReminderScheduled(forSchedule schedule: RailStationTrainSchedule) -> Bool {
        let other = NotificationReminder(fromSchedule: schedule)
        
        return queue.sync {
            let reminders = self.reminders
            
            for reminder in reminders {
                if reminder == other {
                    return true
                }
            }
            
            return false
        }
    }
    
    func saveReminder(forSchedule schedule: RailStationTrainSchedule) -> NotificationReminder? {
        return queue.sync {
            guard let newReminder = NotificationReminder(fromSchedule: schedule) else {
                return nil
            }
            
            if newReminder.timeUntilExpiration < Self.MIN_EXPECTED_EXPIRATION_TIME {
                return nil
            }
            
            var newReminders = self.reminders
            
            newReminders.removeAll { reminder in
                reminder == newReminder
            }
            
            newReminders.append(newReminder)
            
            self.reminders = newReminders
            
            return newReminder
        }
    }
    
    func deleteReminder(forSchedule schedule: RailStationTrainSchedule) -> NotificationReminder? {
        let other = NotificationReminder(fromSchedule: schedule)
        
        queue.sync {
            var newReminders = self.reminders
            
            newReminders.removeAll { reminder in
                reminder == other
            }
            
            self.reminders = newReminders
        }
        
        return other
    }
    
    func deleteExpiredReminders() {
        queue.sync {
            var newReminders = self.reminders
            
            newReminders.removeAll { reminder in
                reminder.isExpired
            }
            
            print(String(describing: Self.self) + "| Deleted \(self.reminders.count - newReminders.count) expired reminders")
            
            self.reminders = newReminders
        }
    }
    
    private var reminders: [NotificationReminder] {
        get {
            let data = defaults.data(forKey: key) ?? Data()
            
            if let result = try? JSONDecoder().decode([NotificationReminder].self, from: data) {
                return result
            }
            
            return []
        }
        set {
            if !newValue.isEmpty {
                if let result = try? JSONEncoder().encode(newValue) {
                    defaults.set(result, forKey: key)
                }
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

struct NotificationReminder: Codable, Hashable {
    var id: String {
        "\(trainCode)-\(firstStopDeparture)"
    }
    
    var trainCode: TrainInfo.Code
    var firstStopName: String
    var firstStopDeparture: Date
    var lastStopName: String
    var lastStopArrival: Date
    
    var isExpired: Bool {
        timeUntilExpiration <= 0
    }
    
    var timeUntilExpiration: TimeInterval {
        max(firstStopDeparture.timeIntervalSince1970 - Date().timeIntervalSince1970, 0)
    }
    
    init?(fromSchedule schedule: RailStationTrainSchedule) {
        self.trainCode = schedule.trainInfo.code
        
        guard let firstStop = schedule.movements.first, let lastStop = schedule.movements.last else {
            return nil
        }
        
        guard let firstStopDeparture = firstStop.current.departure, let lastStopArrival = lastStop.current.arrival else {
            return nil
        }
        
        self.firstStopName = firstStop.current.name
        self.firstStopDeparture = firstStopDeparture
        self.lastStopName = lastStop.current.name
        self.lastStopArrival = lastStopArrival
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
