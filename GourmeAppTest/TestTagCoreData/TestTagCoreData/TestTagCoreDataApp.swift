//
//  TestTagCoreDataApp.swift
//  TestTagCoreData
//
//  Created by 高橋昴希 on 2024/10/19.
//

import SwiftUI

@main
struct TestTagCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RegistrationView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
