//
//  AutosuggestionApp.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/11.
//

import SwiftUI

@main
struct AutosuggestionApp: App {
    
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .preferredColorScheme(.dark)
        }
    }
}
