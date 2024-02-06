//
//  StoreInfoView.swift
//  NavigationStack
//
//  Created by 高橋昴希 on 2024/02/07.
//

import SwiftUI

struct StoreInfoView: View {
    // ホーム画面から受け取った配列パスの参照
    @Binding var navigatePath: [samplePath]
    var body: some View {
        // タップしたら編集画面へ遷移
        Button(action: {
            // 次の画面へ遷移(お店編集画面へ遷移)
            navigatePath.append(.storEdit)
        }) {
            Text("編集画面へ")
                .foregroundStyle(.red)
        }
        // 前のビューに戻る(タップしたらホーム画面)
        Button(action: {
            navigatePath.removeLast()
        }) {
            Text("ホーム画面に戻る")
        }
            .navigationTitle("お店情報画面")
    }
}

// プレビュー表示するための初期値の設定、値何を入れる？
