//
//  StoreEditView.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import PhotosUI
import MapKit

//　StoreEditView:お店編集画面
struct StoreEditView: View {
    // プロパティラッパー @FetchRequestで、データベースよりデータを取得
    @FetchRequest(entity: Stores.entity(), sortDescriptors: []
    ) private var fetchedStores: FetchedResults<Stores>
    // SwiftUIの環境からmanagedObjectContextを取得してCoreDataの操作を行う
    @Environment(\.managedObjectContext) private var viewContext
    // ホーム画面から受け取った配列パスの参照
    @Binding var navigatePath: [HomeNavigatePath]
    // StoreEditViewModelクラスをインスタンス化
    @StateObject private var viewModel = StoreEditViewModel()
    // 選択されたタグを格納するための配列
    @State private var selectedTags: [String] = []
    // タグ選択画面の管理状態
    @State private var isTagSelectionVisible: Bool = false

    var body: some View {
        Spacer()
        // スクリーン画面
        ScrollView {
            VStack {
                // 店名欄
                HStack {
                    Text("お店の名前")
                        .storeInfoTextStyle()
                    // 店名を記載するスペース
                    TextField("", text: $viewModel.editViewDetailData.storeName)
                        // 最大幅
                        .frame(maxWidth: .infinity)
                }
                Divider()
                // 訪問状況欄
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
                Divider()
                // タグ欄
                HStack {
                    Text("タグ")
                        .storeInfoTextStyle()
                    Spacer()
                    Button(action: {
                        // タグ選択画面へ遷移
                        isTagSelectionVisible.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
                Divider()
            }
            .padding(.horizontal, 16)
            // タグ選択画面を表示する際の設定
            .sheet(isPresented: $isTagSelectionVisible) {
                // タグ追加画面を表示
                TagAddView(selectedTags: $selectedTags)
                    // ハーフモーダルで表示。全画面とハーフに可変できるようにする。
                    .presentationDetents([
                        .medium,
                        .large
                    ])
            }
        }
        // NavigationBarを固定する
        .navigationBarTitleDisplayMode(.inline)
        // ナビゲーションタイトルの文字サイズを変更
        .toolbar {
            // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
            ToolbarItem(placement: .principal) {
                Text("お店情報の編集")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
            }
            // ボトムバーにお店リストに編集内容追加ボタンを作成
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    // お店情報画面に遷移
                    navigatePath.removeLast()
                }) {
                    Text("編集内容を追加する")
                        .navigationBottomBarStyle()
                }
            }
        }
    }
}

#Preview {
    StoreEditView(navigatePath: .constant([]))
}

