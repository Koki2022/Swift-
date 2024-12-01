//
//  StoreOverview.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import MapKit

//　StoreInfoView:お店情報画面
struct StoreOverview: View {
    var stores: Stores?
    // ホーム画面から受け取った配列パスの参照
    @Binding var navigatePath: [HomeNavigatePath]
    // タブの選択項目を保持する変数
    @State private var selection: Int = 0
    // メニューを管理するactionSheetの状態を表す変数
    @State private var isMenuVisible: Bool = false
    // お店情報削除の際のアラートを管理する変数
    @State private var isDeleteVisible: Bool = false
    var body: some View {
        // スクロール機能搭載
        ScrollView {
            VStack {
                // TabView実装
                TabView(selection: $selection) {
                    // 写真をダミーで3つ用意
                    ForEach(0..<3, id: \.self) { index in
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                    }
                }
                // スライド型に変更
                .tabViewStyle(.page)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                // TabViewにframeを実装すると正しく画像が表示される
                .frame(width: .infinity, height: 200)
                // 横線
                Divider()
                // お店の名前欄
                HStack {
                    Text("お店の名前")
                        .storeInfoTextStyle()
                    Text(stores?.name ?? "店名なし")
                    Spacer()
                }
                // 横線
                Divider()
                // タグ欄
                HStack {
                    Text("タグ")
                        .storeInfoTextStyle()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let tags = stores?.selectedTag?.split(separator: ",") {
                                ForEach(tags, id: \.self) { tag in
                                    Text("# \(tag)")
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
        // NavigationBarを固定
        .navigationBarTitleDisplayMode(.inline)
        // ナビゲーションタイトル
        .toolbar {
            // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
            ToolbarItem(placement: .principal) {
                Text("お店の名前")
                    .navigationBarTitleStyle()
            }
            // toolbarモディファイアにToolbarItem構造体を渡しtopBarTrailing(右上配置)を指定
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // actionSheetの状態をtrueにする
                    isMenuVisible.toggle()
                }) {
                    Text("編集")
                }
            }
        }
        // 編集ボタン押した際の設定
        .confirmationDialog("", isPresented: $isMenuVisible) {
            Button(action: {
                // 次の画面へ遷移(お店編集画面へ遷移)
                navigatePath.append(.storeEditView)
            }) {
                Text("お店情報を編集する")
            }
            // 削除ボタン実装
            Button("削除する", role: .destructive) {
                // アラート起動
                isDeleteVisible.toggle()
                // このシートを削除する処理
            }
        }
        .alert("削除しますか？", isPresented: $isDeleteVisible) {
            // ダイアログ内で行うアクション処理
            // キャンセルボタン実装
            Button("キャンセル", role: .cancel) {
                // キャンセル実行時の処理
            }
            // 削除ボタン
            Button("削除", role: .destructive) {
                // ホーム画面に戻る
                navigatePath.removeAll()
                // このシートを削除する処理
            }
        } message: {
            // アラートのメッセージ
            Text("この操作は取り消しできません")
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let previewStores = Stores(context: context)
    previewStores.name = "テスト店舗"
    
    return StoreOverview(stores: previewStores, navigatePath: .constant([]))
        .environment(\.managedObjectContext, context)
}
