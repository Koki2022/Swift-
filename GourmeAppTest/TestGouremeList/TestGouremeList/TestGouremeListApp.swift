//
//  TestGouremeListApp.swift
//  TestGouremeList
//
//  Created by 高橋昴希 on 2024/09/14.
//

import SwiftUI

@main
struct TestGouremeListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
