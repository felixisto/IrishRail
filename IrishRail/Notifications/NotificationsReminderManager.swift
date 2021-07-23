//
//  NotificationsReminderManager.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import Resolver

protocol NotificationsReminderManager: AnyObject {
    func askForLocalNotificationsPermission(completion: @escaping (Bool)->Void)
    
    func isReminderScheduled(forSchedule schedule: RailStationTrainSchedule) -> Bool
    func scheduleReminder(forSchedule schedule: RailStationTrainSchedule)
    func unscheduleReminder(forSchedule schedule: RailStationTrainSchedule)
}

class NotificationsReminderManagerImpl: NotificationsReminderManager {
    @Injected var storage: NotificationsReminderStorage
    
    private let center = UNUserNotificationCenter.current()
    private var hasPermission = AtomicValue<Bool>(false)
    
    init() {
        scheduleForAllStoredReminders()
        
        storage.deleteExpiredReminders()
    }
    
    func askForLocalNotificationsPermission(completion: @escaping (Bool)->Void) {
        weak var weakSelf = self
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                weakSelf?.hasPermission.set(granted)
                
                completion(granted)
            }
        }
    }
    
    func isReminderScheduled(forSchedule schedule: RailStationTrainSchedule) -> Bool {
        return storage.isReminderScheduled(forSchedule: schedule)
    }
    
    func scheduleReminder(forSchedule schedule: RailStationTrainSchedule) {
        if !hasPermission.value {
            return
        }
        
        guard let newReminder = storage.saveReminder(forSchedule: schedule) else {
            return
        }
        
        scheduleNotification(for: newReminder)
    }
    
    func unscheduleReminder(forSchedule schedule: RailStationTrainSchedule) {
        guard let deletedReminder = storage.deleteReminder(forSchedule: schedule) else {
            return
        }
        
        if !hasPermission.value {
            return
        }
        
        let identifier = notificationIdentifier(forReminder: deletedReminder)
        
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        print(String(describing: Self.self) + "| Unscheduled local notification with id \(identifier)")
    }
    
    private func scheduleNotification(for reminder: NotificationReminder) {
        let timeUntilExpiration = reminder.timeUntilExpiration
        
        if timeUntilExpiration <= 0 {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Train for '\(reminder.lastStopName)' departing soon"
        
        let identifier = notificationIdentifier(forReminder: reminder)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeUntilExpiration, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let err = error {
                print("Local notification failed to be scheduled, error: \(err)")
            }
        }
        
        print(String(describing: Self.self) + "| Scheduled local notification for \(reminder.lastStopName) with id \(identifier), to expire in \(timeUntilExpiration) seconds")
    }
    
    private func scheduleForAllStoredReminders() {
        for reminder in storage.allReminders {
            scheduleNotification(for: reminder)
        }
    }
    
    private func notificationIdentifier(forReminder reminder: NotificationReminder) -> String {
        return "NotificationsReminderManager.\(reminder.id)"
    }
}

