//
//  SelectedTabViewModel.swift
//  TestTabCoreData
//
//  Created by 高橋昴希 on 2024/10/23.
//

import SwiftUI
import CoreData

class SelectedTabViewModel: ObservableObject {
    @Published var storeName: String = ""
    @Published var tabNumber: Int = 0
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
    // 店名と訪問状況を保存する関数
    func saveStoreInfo(viewContext: NSManagedObjectContext) {
        // NSFetchRequest<Stores>: Storesオブジェクトを返すFetchRequestの型
        // Stores.fetchRequest: Storesエンティティに対するフェッチリクエストを生成するメソッド
        let fetchRequest: NSFetchRequest<Stores> = Stores.fetchRequest()
        // Storesエンティティのnameアトリビュートと完全一致するstoreName変数名を検索するNSPredicate を作成
        fetchRequest.predicate = NSPredicate(format: "name == %@", storeName)
        
        do {
            // 設定したfetchRequestを使用してデータベースからデータを取得
            let existingStores = try viewContext.fetch(fetchRequest)
            let store: Stores
            
            // 既存の店舗が見つかった場合、更新する。
            if let existingStore = existingStores.first {
                store = existingStore
            } else {
                // 新しい店舗を作成
                store = Stores(context: viewContext)
            }
            
            // 店舗情報を設定
            store.name = storeName
            store.tabNumber = String(tabNumber)
            
            // 変更を保存
            try viewContext.save()
            print("店舗情報をCoreDataに保存: 名前: \(storeName), タブ番号: \(tabNumber)")
        } catch {
            print("CoreData Error: \(error)")
        }
    }
}
