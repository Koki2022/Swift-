//
//  HomeViewModel.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/15.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    // データを確認する関数
    func checkStoreDetailData(fetchedStores: FetchedResults<Stores>) {
        print("CoreDataの件数: \(fetchedStores.count)")
        
        for store in fetchedStores {
            let storeName = store.name ?? "名前がありません"
            let address = store.address ?? "住所がありません"
            print("店名: \(storeName), 住所: \(address)")
        }
    }
    // CoreDataに登録されているすべてのデータを削除する関数
    func deleteAllStores(fetchedStores: FetchedResults<Stores>, viewContext: NSManagedObjectContext) {
        for store in fetchedStores {
            viewContext.delete(store)
        }
        
        do {
            try viewContext.save()
            print("すべてのストア情報を削除しました")
        } catch {
            print("削除エラー: \(error)")
        }
    }
}

