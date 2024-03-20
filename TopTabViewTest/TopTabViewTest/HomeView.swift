//
//  HomeView.swift
//  TopTabViewTest
//
//  Created by 高橋昴希 on 2024/03/06.
//

import SwiftUI

struct HomeView: View {
    // タブネームを保持する変数
    let tabName: [String] = ["行った", "気になる"]
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            // 横線
            Divider()
            // 上部タブView
            // ビュー本体
            TabView(selection: $selectedTab) {
                // 行ったお店のView
                GoneHomeView()
                    .tag(0)
                // 気になるお店のView
                FutureHomeView()
                    .tag(1)
            }
        }
    }
}

#Preview {
    HomeView()
}
