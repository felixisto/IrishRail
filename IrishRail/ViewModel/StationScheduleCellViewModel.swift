//
//  StationScheduleCellViewModel.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import Combine
import SwiftUI
import Resolver

class StationScheduleCellViewModel: ObservableObject {
    let model: RailStationTrainSchedule
    
    @Published var isNotificationScheduled: Bool
    @Published var isNotificationPermissionDenied = false
    
    @Published var showNotificationAlert = false
    
    @Injected var notificationsManager: NotificationsReminderManager
    
    var firstMovement: RailStationMovement {
        model.movements.first ?? RailStationMovement()
    }
    
    var lastMovement: RailStationMovement {
        model.movements.last ?? RailStationMovement()
    }
    
    init(model: RailStationTrainSchedule) {
        self.model = model
        self.isNotificationScheduled = false
        updateNotificationScheduledState()
    }
    
    func scheduleOrUnscheduleNotification() {
        weak var weakSelf = self
        
        notificationsManager.askForLocalNotificationsPermission { granted in
            DispatchQueue.main.async {
                guard let strongSelf = weakSelf else {
                    return
                }
                
                strongSelf.isNotificationPermissionDenied = !granted
                
                if !granted {
                    strongSelf.showNotificationAlert = true
                    return
                }
                
                if !strongSelf.isNotificationScheduled {
                    strongSelf.notificationsManager.scheduleReminder(forSchedule: strongSelf.model)
                } else {
                    strongSelf.notificationsManager.unscheduleReminder(forSchedule: strongSelf.model)
                }
                
                strongSelf.updateNotificationScheduledState()
            }
        }
    }
    
    private func updateNotificationScheduledState() {
        self.isNotificationScheduled = notificationsManager.isReminderScheduled(forSchedule: model)
    }
}
