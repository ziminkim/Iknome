//
//  AlarmView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/27.
//

import SwiftUI
import UserNotifications
import CoreData


struct AlarmView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    var memento: FetchedResults<Item>.Element
    @Environment(\.dismiss) var dismiss //go back
    @State var selectedDate: Date = Date()
    @State var alert = false
    static let instance = NotificationManager() //singleton
    
    enum Day: Int, CaseIterable {
        case 일
        case 월
        case 화
        case 수
        case 목
        case 금
        case 토
        
        var description : String {
            switch self {
            case .일 : return "일"
            case .월 : return "월"
            case .화 : return "화"
            case .수 : return "수"
            case .목 : return "목"
            case .금 : return "금"
            case .토 : return "토"
            }
        }
    }
    @State private var selectedDays: [Day] = []
    
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20){
                
                //select time
                DatePicker("",selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden() //라벨 없애서 중앙정렬

                
                //repeat
                HStack(spacing: 40) {
                    Text("반복")
                        .foregroundColor(.blue)
                    
                    HStack {
                        ForEach(Day.allCases, id: \.self) { day in
                            Text(day.description)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(selectedDays.contains(day)
                                            ? Color(uiColor: .lightGray)
                                                .opacity(80).cornerRadius(10)
                                            : Color(uiColor: .secondarySystemGroupedBackground).cornerRadius(10))
                                .onTapGesture {
                                                if selectedDays.contains(day) {
                                                    selectedDays.removeAll(where: {$0 == day})
                                                } else {
                                                    selectedDays.append(day)
                                                }
                                            }
                            
                        }
                    }
                    //RepeatView()
                    //selectRepeat.toggle()
                }
                .frame(width:350 , height: 16)
                .padding()
                

                
                //알람 삭제
                Button("알람 삭제"){
                    //알람 삭제 버튼 누르면 notification delete
                    //경고창 하나 띄우기 알람을 삭제하시겠습니까?
                    //이거 맞나
                    cancelNotification(name: memento.name!)
                    //memento에 alarm -> " "
                    DataController().addAlarm(memento: memento, name: memento.name!, alarm: "반복 없음", context: managedObjectContext)
                }
                .frame(width:350 , height: 16)
                .padding()
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .cornerRadius(10)
                
                
                Spacer() //이거하니까 위로 올라감
                
            }
            .padding()
            .navigationBarTitle("알람 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        //선택한 시간 받아오기
                        let formath = DateFormatter()
                        formath.dateFormat = "HH"
                        let formatm = DateFormatter()
                        formatm.dateFormat = "mm"
                        var hh = formath.string(from: selectedDate)
                        var mm = formatm.string(from: selectedDate)
                        //기존에 있는거 지우고
                        cancelNotification(name: memento.name!)
                        //알랆 세팅
                        for day in selectedDays {
                            scheduleNotification(
                                hour: hh,
                                minute: mm,
                                name: memento.name!,
                                selectedDay: day)
                        }
                        
                        //메멘토에 저장
                        //매주 월요일, 화요일 00:00시 반복
                        //enum type array 출력하는 법 -> 위에도 적용
                        //selectedDays는 배열
                        //배열안에 항목만 출력
                        if selectedDays.count != 0 {
                            
                            var alarm = "반복, "
                            
                            for day in selectedDays {
                                alarm = alarm + " " + String(day.description)
                            }
                            
                            alarm = alarm + " \(hh):\(mm)"
                            DataController().addAlarm(memento: memento, name: memento.name!, alarm: alarm, context: managedObjectContext)
                        }
                        
                        dismiss()
                    }

                }
            }
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text("Error"), message: Text("알람 표시 권한이 없습니다")
            )
        })
        .onAppear {//뷰가 열릴 때 실행
            requestAuthorization()
        }
    }
    
    func requestAuthorization()  {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { //권한을 받아오는 함수 실행
            (success, error) in
            if !success {
                alert.toggle()
                
            } else {
                
            }
            
        }
        
    }
    
    func scheduleNotification(hour: String, minute: String, name: String, selectedDay: Day) {
        
        let content = UNMutableNotificationContent()
        content.title = "Memento"
        content.subtitle = "'\(name)'를 기억할 시간입니다."
        content.sound = .default
        content.badge = 1 //앱 아이콘 위옆에 1 뜨는거
        
        //trigger = time, calendar, location
        //time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = Int(hour)
        dateComponents.minute = Int(minute)
        dateComponents.weekday = selectedDay.rawValue
        
        
        //dateComponents.weekday = selectedDays 다중선택이 안되네
        //weekday, weekofmonth, 등 다양하게 가능
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //location
        //let trigger = UNLocationNotificationTrigger(region: , repeats: )
        
       //identifier를 memento.name으로?
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(name: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [UUID().uuidString])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [UUID().uuidString])
    }
}
