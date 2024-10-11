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
            
            if let existingStore = existingStores.first {
                // 既存の店舗が見つかった場合、更新する。
                store = existingStore
            } else {
                // 新しい店舗を作成
                store = Stores(context: viewContext)
            }
            
            // 店舗情報を設定
            store.name = storeName
            store.address = address
            
            // 変更を保存
            try viewContext.save()
            print("店舗情報をCoreDataに保存: 名前: \(storeName), 住所: \(address)")
        } catch {
            print("CoreData Error: \(error)")
        }
    }
}


