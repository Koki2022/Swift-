//
//  SearchBarView.swift
//  OriginalSearchBarTest
//
//  Created by 高橋昴希 on 2024/03/02.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var inputText: String
    var body: some View {
        ZStack {
            // 背景の設定
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 350, height: 40)
            HStack(spacing: 6) {
                // アイコンと入力欄の位置調整
                Spacer()
                    .frame(width: 25)
                // 虫眼鏡のアイコン
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                // 入力欄
                TextField("search", text: $inputText)
            }
        }
    }
}

#Preview {
    SearchBarView(inputText: .constant(""))
}
