//
//  UserNotification.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/28.
//


import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization()  {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { //권한을 받아오는 함수 실행
            (success, error) in
            if let error = error {
                print("error : \(error)")
                
            } else {
                print("success")
            }
            
        }
        
    }
    
    func scheduleNotification(hour: Int, minute: Int) {
        
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
        dateComponents.hour = hour
        dateComponents.minute = minute
        //weekday, weekofmonth, 등 다양하게 가능
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
                //NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification(hour: 10, minute: 30)
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
