//
//  StoreEditView.swift
//  GourmeListApp
//
//  Created by 高橋昴希 on 2024/01/30.
//

import SwiftUI
import PhotosUI

//　StoreEditView:お店編集画面
struct StoreEditView: View {
    // ホーム画面から受け取った配列パスの参照
    @Binding var navigatePath: [HomeNavigatePath]
    @State var storeInfoData: StoreInfoData = StoreInfoData(selectedItems: [], selectedImages: [], storeName: "", visitStatusTag: 0, visitDate: Date(), memo: "", businessHours: "", phoneNumber: "", postalCode: "", address: "")
    // お店検索画面シートの状態を管理する変数。
    @State private var isStoreSearchVisible: Bool = false
    // 訪問日を設定するシートの状態を管理する変数。
    @State private var isVisitDateVisible: Bool = false
    // タグ選択画面のシートの状態を管理する変数。
    @State private var isTagSelectionVisible: Bool = false

    var body: some View {
        Spacer()
        // スクリーン画面
        ScrollView {
            //　カスタムViewを実装
            // カスタムViewを実装
            StoreInfoEditorView(storeInfoData: $storeInfoData, isStoreSearchVisible: $isStoreSearchVisible, isVisitDateVisible: $isVisitDateVisible, isTagSelectionVisible: $isTagSelectionVisible)
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
            // ボトムバーにお店リストに追加ボタンを作成
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    // 登録した情報を保存
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
