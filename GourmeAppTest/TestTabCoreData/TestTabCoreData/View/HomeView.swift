//
//  ContentView.swift
//  TestTabCoreData
//
//  Created by 高橋昴希 on 2024/10/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    // predicateで初期値を設定
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [], predicate: (NSPredicate(format: "tabNumber == %@", "0")))
    private var fetchedStores: FetchedResults<Stores>
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = HomeViewModel()
    @State private var isShowSheet: Bool = false
    @State private var tabNumber: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                if !fetchedStores.isEmpty {
                    Picker("行った気になるを選択", selection: $tabNumber) {
                        Text("行った").tag(0)
                        Text("気になる").tag(1)
                    }
                    .pickerStyle(.segmented)
                    // CoreDataから取得したデータをリスト表示
                    List {
                        ForEach(fetchedStores) { store in
                            Text(store.name ?? "店名なし")
                        }
                    }
                    Button(action: {
                        isShowSheet.toggle()
                    }) {
                        Text("追加画面")
                    }
                    .sheet(isPresented: $isShowSheet) {
                        SelectedTabView()
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
                        SelectedTabView()
                    }
                }
            }
            // 画面起動時のデータ確認
            .onAppear {
                viewModel.checkStoreDetailData(fetchedStores: fetchedStores)
            }
            // onChangeを使用してfetchedStoresのpredicateを更新
            .onChange(of: tabNumber) {
                // tabNumberが変更された際に動的にフィルタリング
                fetchedStores.nsPredicate = NSPredicate(format: "tabNumber == %@", String(tabNumber))
            }
            .navigationTitle("お店一覧")
        }
    }
}

#Preview {
    HomeView()
}
