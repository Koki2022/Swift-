//
//  StoreRegistrationViewModel.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import CoreData

class StoreRegistrationViewModel: ObservableObject {
    // @Published:ObservedObjectプロパティに準拠したクラス内部のプロパティを監視し、複数のviewに対して自動通知を行うことができる
    @Published var registrationViewDetailData: StoreDetailData = StoreDetailData()
    // 訪問状態を管理する変数
    @Published var visitationStatus: VisitationStatus = .visited
    // 選択されたタグを格納するための配列
    @Published var selectedTags: [String] = []
    // タグ選択画面の管理状態
    @Published var isTagSelectionVisible: Bool = false

 
    //　CoreDataにお店情報を登録する関数
    func saveStoreInfo(fetchedStores: FetchedResults<Stores>, viewContext: NSManagedObjectContext) {
        // NSFetchRequest<Stores>: Storesオブジェクトを返すFetchRequestの型, Stores.fetchRequest: Storesエンティティに対するフェッチリクエストを生成するメソッド
        let fetchRequest: NSFetchRequest<Stores> = Stores.fetchRequest()
        // Storesエンティティのnameアトリビュートと完全一致するstoreName変数名を検索するNSPredicate を作成
        fetchRequest.predicate = NSPredicate(format: "name == %@", registrationViewDetailData.storeName)

        // CoreData保存処理の際do-try文でエラー処理も記載
        do {
            // 設定したfetchRequestを使用してデータベースからデータを取得
            let existingStores = try viewContext.fetch(fetchRequest)
            let store: Stores
            // 既存の店舗が見つかった場合、更新する。
            if let existingStore = existingStores.first {
                store = existingStore
            } else {
                store = Stores(context: viewContext)
            }

            // 店名をStoresEntityのnameAttributeに格納
            store.name = registrationViewDetailData.storeName
            // 選択した訪問状況をStoresEntityのvisitationStatusへ格納
            store.visitationStatus = visitationStatus.rawValue
            // 選択したタグをStoresEntityのselectedTagAttributeへ格納
            store.selectedTag = selectedTags.joined(separator: ",")
        
            // CoreDataに保存
            try viewContext.save()
            print("CoreData 店名保存完了: \(store.name ?? "")")
            print("CoreData 訪問状況の管理番号の登録完了: \(visitationStatus.rawValue)")
            print("CoreData 選択したタグの登録完了: \(selectedTags)")
        } catch {
            print("CoreData ERROR: \(error)")
        }
    }
}
