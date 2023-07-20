//
//  icaloriesApp.swift
//  icalories
//
//  Created by 김지민 on 2023/07/14.
//

import SwiftUI

@main
struct icaloriesApp: App {
    //inject database
    @StateObject private var dataController = DataController()
    //DataController 클래스는 ObservableObject 프로토콜을 따름
    //dataController 객체는 icaloriesApp 화면을 가진 화면이 재생성되어도 그대로 유지?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
