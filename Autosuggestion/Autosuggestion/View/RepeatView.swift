//
//  RepeatView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/28.
//

//월화수목금 선택해서 반복 설정하는 뷰
import SwiftUI

struct RepeatView: View {
    
    enum Day: String, CaseIterable {
        case 일요일
        case 월요일
        case 화요일
        case 수요일
        case 목요일
        case 금요일
        case 토요일
    }
    @State private var selectedDays: [Day] = []
    
    var body: some View {

        HStack {
            ForEach(Day.allCases, id: \.self) { day in
                Text(String(day.rawValue.first!))
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
            
    }
}

struct RepeatView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatView()
    }
}
