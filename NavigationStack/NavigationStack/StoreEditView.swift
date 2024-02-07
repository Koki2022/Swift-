//
//  StoreEditView.swift
//  NavigationStack
//
//  Created by 高橋昴希 on 2024/02/07.
//

import SwiftUI

struct StoreEditView: View {
    @Binding var navigatePath: [samplePath]
    var body: some View {
        Button(action: {
            // 最初のビューに戻る(タップしたらホーム画面) = 配列のすべての要素を削除
            navigatePath.removeAll()
        }) {
            Text("ホーム画面に戻る")
        }
        .navigationTitle("お店編集画面")
    }
}

