//
//  LocalNotification.swift
//  Reminder
//
//  Created by 김지민 on 2023/07/27.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) {
            (success, error) in
            if let error = error {
                print("error : \(error)")
            } else {
                print("success")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "this is sooo easy"
        content.sound = .default
        content.badge = 1 //앱 아이콘 위옆에 1 뜨는거
        
        //trigger = time, calendar, location
        //time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 14
        dateComponents.minute = 19
        //weekday, weeofmonth, 등 다양하게 가능
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //location
        //let trigger = UNLocationNotificationTrigger(region: , repeats: )
        
       
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotification: View {
    var body: some View {
        VStack(spacing: 40) {
            
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }

        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }//앱 실행하면 배지 0으로 바꿔주기!
    }
}

struct LocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotification()
    }
}
