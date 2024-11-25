//
//  TestFilteredListApp.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI

@main
struct TestFilteredListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
