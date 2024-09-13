//
//  StoreRegistrationView.swift
//  GourmeListApp
//
//  Created by 高橋昴希 on 2024/01/31.
//

import SwiftUI
import PhotosUI

//　StoreRegistrationView:お店登録画面
struct StoreRegistrationView: View {
    // タグ選択画面を閉じるための動作を呼び出す変数。
    @Environment(\.dismiss) private var dismiss
    @State var storeInfoData: StoreInfoData = StoreInfoData(selectedItems: [], selectedImages: [], storeName: "", visitStatusTag: 0, visitDate: Date(), memo: "", businessHours: "", phoneNumber: "", postalCode: "", address: "")
    // お店検索画面シートの状態を管理する変数。
    @State private var isStoreSearchVisible: Bool = false
    // 訪問日を設定するシートの状態を管理する変数。
    @State private var isVisitDateVisible: Bool = false
    // タグ選択画面のシートの状態を管理する変数。
    @State private var isTagSelectionVisible: Bool = false

    var body: some View {
        NavigationStack {
            Spacer()
            ScrollView {
                // カスタムViewを実装
                StoreInfoEditorView(storeInfoData: $storeInfoData, isStoreSearchVisible: $isStoreSearchVisible, isVisitDateVisible: $isVisitDateVisible, isTagSelectionVisible: $isTagSelectionVisible)
                    // NavigationBarを固定する
                    .navigationBarTitleDisplayMode(.inline)
                    // ナビゲーションタイトルの文字サイズを変更
                    .toolbar {
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
                                // 登録した情報を保存
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
    }
}

#Preview {
    StoreRegistrationView()
}
