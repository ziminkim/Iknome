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
    @State var selectRepeat = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20){
                
                //Rectangle().frame(height:0)
                //select time
                DatePicker("",selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden() //라벨 없애서 중앙정렬
                
                //repeat
                HStack {
                    Spacer()
                    Button("반복"){
                        selectRepeat.toggle()
                    }
                    Spacer()
                }
                .frame(height: 20)
                .padding()
                .background(Color.secondary)
                .cornerRadius(20)
                
                //----------------------------
                //반복 버튼 누르면 창나오게
                //알람 삭제 버튼 누르면 notification delete
                //여기 버튼 만들다가 디자인 너무 이상해서 스톱
                //예시 자료를 좀 많이 만들어 봐야할듯
                
                //알람 삭제
                Button("알람 삭제"){
                    
                }
                .background(Color.secondary)
                .cornerRadius(20)
                
                Spacer() //이거하니까 위로 올라감
                
            }
            .padding()
            .navigationBarTitle("알람 편집")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $selectRepeat){
                RepeatView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //save time, hour, repeat
                        
                        
                        dismiss()
                    } label: {
                        Text("완료")
                    }

                }
            }
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text("Error"), message: Text("알람 표시 권한이 없습니다")
            )
        })
        .onAppear {//뷰가 열릴 때 실행
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { //권한을 받아오는 함수 실행
                (success, error) in
                if !success {
                    alert.toggle()
                } else {
                    //권한있으면 뭘가져오냐?
                }
                
            }
        }
    }
}
