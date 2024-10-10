//
//  TestMapAndAddressViewModel.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/11.
//

import SwiftUI
import CoreData

class TestMapAndAddressViewModel: ObservableObject {
    @Published var storeName: String = ""
    @Published var address: String = ""
    
    func addStoreName(viewContext: NSManagedObjectContext) {
        let store = Stores(context: viewContext)
        store.name = storeName
        
        do {
            try viewContext.save()
            print("店名をCoreDataに保存: \(storeName)")
        } catch {
            print("CoreData Error: \(error)")
        }
    }
    
    func addAddress(viewContext: NSManagedObjectContext) {
        let store = Stores(context: viewContext)
        store.address = address
        
        do {
            try viewContext.save()
            print("住所をCoreDataに保存: \(address)")
        } catch {
            print("CoreData Error: \(error)")
        }
    }
}

