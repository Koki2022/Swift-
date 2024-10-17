//
//  FirstView.swift
//  TestOriginalSearchBar
//
//  Created by 高橋昴希 on 2024/06/09.
//

import SwiftUI

struct FirstView: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            OriginalSearchBarView(text: $searchText, prompt: "タグの名前を検索")
        }
    }
}

#Preview {
    FirstView()
}
