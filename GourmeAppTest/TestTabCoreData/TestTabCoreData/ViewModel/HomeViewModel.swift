//
//  HomeViewModel.swift
//  TestTabCoreData
//
//  Created by 高橋昴希 on 2024/10/21.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    // データを確認する関数
    func checkStoreDetailData(fetchedStores: FetchedResults<Stores>) {
        print("CoreDataの件数: \(fetchedStores.count)")
        
        for store in fetchedStores {
            let storeName = store.name ?? "名前がありません"
            let tabNumber = store.tabNumber ?? "タブ番号なし"
            if tabNumber == "0" {
                print("店名: \(storeName), タブ番号: \(tabNumber), 行ったリストで管理")
            } else if tabNumber == "1" {
                print("店名: \(storeName), タブ番号: \(tabNumber), 気になるリストで管理")
            }
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

