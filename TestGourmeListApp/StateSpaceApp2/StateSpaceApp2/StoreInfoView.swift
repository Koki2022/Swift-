//
//  CompletedView.swift
//  StateSpaceApp2
//
//  Created by 高橋昴希 on 2024/02/12.
//

import SwiftUI

struct StoreInfoView: View {
    @Binding var isStoreEditSheet: Bool
    // お店情報画面を閉じるための動作を呼び出す変数
    @Environment(\.dismiss) private var storeInfoViewDismiss
    var body: some View {
        // タップしたら編集画面へ遷移
        Button(action: {
            isStoreEditSheet.toggle()
        }) {
            Text("編集画面へ")
                .foregroundStyle(.red)
        }
        // 前のビューに戻る(タップしたらホーム画面)
        Button(action: {
            // お店情報画面を閉じて一覧画面へ遷移
            storeInfoViewDismiss()
        }) {
            Text("ホーム画面に戻る")
        }
        .navigationTitle("お店情報画面")
        // お店編集画面を閉じた際にこのシートも閉じる
        .sheet(isPresented: $isStoreEditSheet) {
            StoreEditView()
        }
    }
}


