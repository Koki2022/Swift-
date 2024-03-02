//
//  ContentView.swift
//  OriginalSearchBarTest
//
//  Created by 高橋昴希 on 2024/03/02.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    var body: some View {
        // searchableモディファイアはNavigationStackにラップする必要あり
        NavigationStack {
            // 自作の検索バーを表示するビュー
            SearchBarView(inputText: $inputText)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            HStack {
                // ダミータグ
                Text("タグ")
                    .font(.system(size: 20))
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .foregroundStyle(.black)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(10)
                
                Spacer()
            }
            List(0..<100) { _ in
                Text("ダミー")
            }
            // ナビゲーションバーの固定
            .navigationBarTitleDisplayMode(.inline)
            // ナビゲーションバーの背景色
            .toolbarBackground(Color.yellow, for: .navigationBar)
            // 背景の視覚設定
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                // 中央配置
                ToolbarItem(placement: .principal) {
                    Text("ホーム画面")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                }
                ToolbarItem(placement: .bottomBar) {
                    // ダミー追加
                    Text("お店を追加")
                        .font(.system(size: 20))
                        .frame(width: 350, height: 70)
                        .foregroundStyle(.white)
                        .background(Color.red)
                        .clipShape(.buttonBorder)
                        .padding(10)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
