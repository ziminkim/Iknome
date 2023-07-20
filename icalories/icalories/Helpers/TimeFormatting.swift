//
//  TimeFormatting.swift
//  icalories
//
//  Created by 김지민 on 2023/07/17.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow) / 60
    let hours = minutes/60
    let days = hours/60
    
    if minutes < 120 {
        return "\(minutes) minutes age"
    } else if minutes >= 120 && hours < 48 {
        return "\(hours) hours ago"
    } else {
        return "\(days) days ago"
    }
}
