//
//  StoreEditView.swift
//
//  Created by 高橋昴希 on 2024/02/07.
//

import SwiftUI

struct StoreEditView: View {
    // お店情報のシートの状態を管理する状態を管理する変数
    @Binding var storeEditIsShowSheet: Bool
    var body: some View {
        Button(action: {
            storeEditIsShowSheet.toggle()
        }) {
            Text("ホーム画面に戻る")
        }
        .navigationTitle("お店編集画面")
    }
}

