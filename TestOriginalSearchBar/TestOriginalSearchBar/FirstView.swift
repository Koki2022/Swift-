//
//  ContentView.swift
//  TestOriginalSearchBar
//
//  Created by 高橋昴希 on 2024/06/09.
//

import SwiftUI

// 別のファイルやViewからの呼び出し例
struct FirstView: View {
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            OriginalSearchBarView(text: $searchText, prompt: "タグの名前を検索")
            OriginalSearchBarView(text: $searchText, prompt: "アイテムを検索")
        }
    }
}

#Preview {
    FirstView()
}
