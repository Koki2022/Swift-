//
//  StoreEditView.swift
//  StateSpaceApp2
//
//  Created by 高橋昴希 on 2024/02/13.
//

import SwiftUI

struct StoreEditView: View {
    // 環境変数の取得
    @Environment (\.isPresentingModal) var isPresentedModally
    var body: some View {
        Button(action: {
            // 環境変数に対して状態変更を適応
            isPresentedModally.wrappedValue.toggle()
        }) {
            Text("ホーム画面に戻る")
        }
        .navigationTitle("お店編集画面")
    }
}
