//
//  TestMapAndAddressApp.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/11.
//

import SwiftUI

@main
struct TestMapAndAddressApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
