//
//  StoreRegistrationView.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import CoreData

//　StoreRegistrationView:お店登録画面
struct StoreRegistrationView: View {
    // プロパティラッパー @FetchRequestで、データベースよりデータを取得
    @FetchRequest(entity: Stores.entity(), sortDescriptors: []
    ) private var fetchedStores: FetchedResults<Stores>
    // SwiftUIの環境からmanagedObjectContextを取得してCoreDataの操作を行う
    @Environment(\.managedObjectContext) private var viewContext
    // タグ選択画面を閉じるための動作を呼び出す変数。
    @Environment(\.dismiss) private var dismiss
    // StoreRegistrationViewModelクラスをインスタンス化
    @StateObject private var viewModel = StoreRegistrationViewModel()
    
    var body: some View {
        NavigationStack {
            Spacer()
            ScrollView {
                VStack {
                    // 店名欄
                    storeNameField
                    Divider()
                    // 訪問状況欄
                    visitationStatusField
                    Divider()
                    // タグ欄
                    tagField
                    Divider()
                }
                .padding(.horizontal, 16)
                Button("キャンセル", role: .cancel) { }
            }
            // タグ選択画面を表示する際の設定
            .sheet(isPresented: $viewModel.isTagSelectionVisible) {
                tagAddSheet
            }
            // NavigationBarを固定する
            .navigationBarTitleDisplayMode(.inline)
            // ナビゲーションタイトルの文字サイズを変更
            .toolbar {
                // navigationBarItemsを呼び出す
                navigationBarItems
            }
        }
    }
    // 店名欄コンポーネント化
    private var storeNameField: some View {
        // 店名欄
        HStack {
            Text("お店の名前")
                .storeInfoTextStyle()
            // 店名を記載するスペース
            TextField("", text: $viewModel.registrationViewDetailData.storeName)
            // 最大幅
                .frame(maxWidth: .infinity) 
        }
    }
    // 訪問状況欄コンポーネント化
    private var visitationStatusField: some View {
        HStack {
            Text("訪問状況")
                .storeInfoTextStyle()
            // Picker
            Picker("訪問状況を選択", selection: $viewModel.visitationStatus) {
                Text("行った").tag(VisitationStatus.visited)
                Text("気になる").tag(VisitationStatus.interested)
            }
            Spacer()
        }
    }
    
    // タグ欄コンポーネント化
    private var tagField: some View {
        HStack {
            Text("タグ")
                .storeInfoTextStyle()
            // TagAddViewで選択されたタグを表示
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.selectedTags, id: \.self) { tag in
                        Text("# \(tag)")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
            Button(action: {
                // タグ選択画面へ遷移
                viewModel.isTagSelectionVisible.toggle()
            }) {
                Image(systemName: "plus.circle")
            }
        }
    }
    
    // タグ追加シートコンポーネント化
    private var tagAddSheet: some View {
        // タグ追加画面を表示
        TagAddView(selectedTags: $viewModel.selectedTags)
        // ハーフモーダルで表示。全画面とハーフに可変できるようにする。
            .presentationDetents([
                .medium,
                .large
            ])
    }
    //　NavigationBarItemをコンポーネント化
    private var navigationBarItems: some ToolbarContent {
        // 複数のToolbarItemをGroupでまとめる
        Group {
            // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
            ToolbarItem(placement: .principal) {
                Text("お店情報の登録")
                    .navigationBarTitleStyle()
            }
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
            // ボトムバーにお店リストに追加ボタンを作成
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    // 登録したお店情報をCoreDataに保存
                    viewModel.saveStoreInfo(fetchedStores: fetchedStores, viewContext: viewContext)
                    // ホーム画面に遷移
                    dismiss()
                }) {
                    Text("お店リストに追加")
                        .navigationBottomBarStyle()
                }
            }
        }
    }
}

#Preview {
    StoreRegistrationView()
}
