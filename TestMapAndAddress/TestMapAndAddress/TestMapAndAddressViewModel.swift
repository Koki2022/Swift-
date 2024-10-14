//
//  TestMapAndAddressViewModel.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/11.
//

import SwiftUI
import CoreData
import MapKit

class TestMapAndAddressViewModel: ObservableObject {
    // 店名
    @Published var storeName: String = ""
    // 住所
    @Published var address: String = ""
    // 検索結果の場所を保持する
    @Published var selectedLocation: MKMapItem?
    // 地図のカメラ位置を保持する
    @Published var position: MapCameraPosition = .automatic
    
    // データを確認する関数
    func checkStoreDetailData(fetchedStores: FetchedResults<Stores>) {
        print("CoreDataの件数: \(fetchedStores.count)")
        
        for store in fetchedStores {
            let storeName = store.name ?? "名前がありません"
            let address = store.address ?? "住所がありません"
            print("店名: \(storeName), 住所: \(address)")
        }
    }
    // 住所を検索する関数
    func searchAddress() {
        // 地図上の特定の場所、施設、住所などを検索するためのリクエストを作成
        let request = MKLocalSearch.Request()
        
        // 検索項目の文字列に入力した住所を格納
        request.naturalLanguageQuery = address
        
        // 指定された検索リクエストに基づいて地図上の場所を検索するためのクラス
        let search = MKLocalSearch(request: request)
        // 検索を非同期で開始。クロージャ内で検索結果または検索エラーを受け取る。
        search.start { response, error in
            // 検索結果（response）が存在するかチェック
            guard let response = response else {
                // 結果がない場合,エラーメッセージを出力して処理を終了。
                print("検索エラー: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            // 検索結果の最初の項目（mapItems.first）を取得
            if let firstItem = response.mapItems.first {
                // 最初の検索結果を selectedLocation に設定し地図上にマーカーが表示される
                self.selectedLocation = firstItem
                // 検索結果の座標を中心に新しい地図領域を作成
                self.position = .region(MKCoordinateRegion(
                    center: firstItem.placemark.coordinate,
                    // latitudeDelta と longitudeDelta の値（0.05）は、地図のズームレベルを決定
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                ))
            }
        }
    }
    // 店名と住所を保存する関数
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
            store.address = address
            
            // 変更を保存
            try viewContext.save()
            print("店舗情報をCoreDataに保存: 名前: \(storeName), 住所: \(address)")
        } catch {
            print("CoreData Error: \(error)")
        }
    }
}


