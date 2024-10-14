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
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [])
    private var fetchedStores: FetchedResults<Stores>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TestMapAndAddressViewModel()
    
    var body: some View {
        NavigationStack {
            Spacer()
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
                            viewModel.searchAddress()
                        }
                }
                Divider()
                // 指定した初期のカメラ位置を使用して新しいマップを作成
                Map(position: $viewModel.position) {
                    // 位置情報が存在すればピンを立てる
                    if let location = viewModel.selectedLocation {
                        Marker(item: location)
                    }
                }
                HStack {
                    Button(action: {
                        // お店情報をCoreDataに追加
                        viewModel.saveStoreInfo(viewContext: viewContext)
                        // 追加後のデータ確認
                        viewModel.checkStoreDetailData(fetchedStores: fetchedStores)
                        dismiss()
                    }) {
                        Text("お店リストに追加")
                    }
                }
            }
            .toolbar {
                // ナビゲーション バーの先端に戻るボタン配置
                ToolbarItem(placement: .cancellationAction) {
                    // 戻るボタン
                    Button(action: {
                        // ホーム画面に戻る
                        dismiss()
                    }) {
                        Text("戻る")
                    }
                }
            }
        }
    }
   
}

// プレビュー用にCoreDataのフェイクコンテキストを使用して、データの保存操作が失敗してクラッシュすることを防ぐ
#Preview {
    TestMapAndAddressView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
