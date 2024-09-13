//
//  PhotoCoreDataApp.swift
//  PhotoCoreData
//
//  Created by 高橋昴希 on 2024/08/02.
//

import SwiftUI

@main
struct PhotoCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PhotoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
