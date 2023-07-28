//
//  DatePicker.swift
//  Reminder
//
//  Created by 김지민 on 2023/07/28.
//

import SwiftUI

struct DatePickerPrac: View {
    
    @State var selectedDate: Date = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2020)) ?? Date()
    let endingDate: Date = Date()
    
    var body: some View {
        
        DatePicker("select a date", selection: $selectedDate
                   , displayedComponents: [.hourAndMinute]
                   )
            .accentColor(Color.red)
            .datePickerStyle(WheelDatePickerStyle())
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerPrac()
    }
}
