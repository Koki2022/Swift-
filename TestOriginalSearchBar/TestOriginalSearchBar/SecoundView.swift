//
//  SecoundView.swift
//  TestOriginalSearchBar
//
//  Created by 高橋昴希 on 2024/06/09.
//

import SwiftUI

struct SecoundView: View {
    @State private var searchText: String = ""
    var body: some View {
        OriginalSearchBarView(text: $searchText, prompt: "アイテムを検索")
    }
}

#Preview {
    SecoundView()
}
