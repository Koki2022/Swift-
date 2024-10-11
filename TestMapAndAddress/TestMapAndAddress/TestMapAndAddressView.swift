//
//  ContentView.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/11.
//

import SwiftUI
import CoreData
import MapKit

struct TestMapAndAddressView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [])
    private var stores: FetchedResults<Stores>
    @StateObject private var viewModel = TestMapAndAddressViewModel()
    // 地図上のカメラの位置と向きを自動に設定
    @State private var position: MapCameraPosition = .automatic
    // 地図上の特定の位置や場所を表すMapKitフレームワークの型
    @State private var selectedLocation: MKMapItem?
    
    var body: some View {
        VStack {
            HStack {
                Text("お店の名前")
                    .foregroundStyle(Color.gray)
                TextField("", text: $viewModel.storeName)
                    .frame(maxWidth: .infinity)
            }
            Divider()
            HStack {
                Text("住所")
                    .foregroundStyle(Color.gray)
                TextField("", text: $viewModel.address)
                    .frame(maxWidth: .infinity)
                    .onSubmit {
                        searchAddress()
                    }
            }
            Divider()
            // 指定した初期のカメラ位置を使用して新しいマップを作成
            Map(position: $position) {
                // 位置情報が存在すればピンを立てる
                if let location = selectedLocation {
                    Marker(item: location)
                }
            }
            Button(action: {
                viewModel.saveStoreInfo(viewContext: viewContext)
            }) {
                Text("保存")
            }
        }
    }
    
    // 住所を検索する関数
    func searchAddress() {
        // 地図上の特定の場所、施設、住所などを検索するためのリクエストを作成
        let request = MKLocalSearch.Request()
        
        // 検索項目の文字列に入力した住所を格納
        request.naturalLanguageQuery = viewModel.address
        
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
}

#Preview {
    TestMapAndAddressView()
}
