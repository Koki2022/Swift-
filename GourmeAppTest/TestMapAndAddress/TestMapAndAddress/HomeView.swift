//
//  HomeView.swift
//  TestMapAndAddress
//
//  Created by 高橋昴希 on 2024/10/14.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [])
    private var fetchedStores: FetchedResults<Stores>
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = HomeViewModel()
    @State private var isShowSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !fetchedStores.isEmpty {
                    // CoreDataから取得したデータをリスト表示
                    List {
                        ForEach(fetchedStores) { store in
                            NavigationLink(destination: StoreDetailView()) {
                                Text(store.name ?? "")
                            }
                        }
                    }
                    Button(action: {
                        isShowSheet.toggle()
                    }) {
                        Text("追加画面")
                    }
                    .sheet(isPresented: $isShowSheet) {
                        TestMapAndAddressView()
                    }
                    Button(action: {
                        // データ全削除
                        viewModel.deleteAllStores(fetchedStores: fetchedStores, viewContext: viewContext)
                        // データ確認
                        viewModel.checkStoreDetailData(fetchedStores: fetchedStores)
                    }) {
                        Text("リストを全て削除")
                            .foregroundStyle(Color.red)
                    }
                  
                } else {
                    Text("お店リストを追加しよう！")
                    Button(action: {
                        isShowSheet.toggle()
                    }) {
                        Text("追加画面")
                    }
                    .sheet(isPresented: $isShowSheet) {
                        TestMapAndAddressView()
                    }
                }
            }
            // 画面起動時のデータ確認
            .onAppear {
                viewModel.checkStoreDetailData(fetchedStores: fetchedStores)
            }
            .navigationTitle("お店一覧")
        }
    }
}

// プレビュー用にCoreDataのフェイクコンテキストを使用して、データの保存操作が失敗してクラッシュすることを防ぐ
#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
