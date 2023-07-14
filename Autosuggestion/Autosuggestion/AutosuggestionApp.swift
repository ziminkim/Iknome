//
//  AutosuggestionApp.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/11.
//

import SwiftUI

@main
struct AutosuggestionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RecordView2()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
