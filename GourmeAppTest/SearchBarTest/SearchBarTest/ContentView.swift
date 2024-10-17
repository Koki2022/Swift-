//
//  ContentView.swift
//  SearchBarTest
//
//  Created by 高橋昴希 on 2024/03/02.
//

import SwiftUI

struct ContentView: View {
    // 検索バーに入力する文字を格納する変数
    @State private var inputText = ""
    var body: some View {
        NavigationStack {
            // ダミーリスト100個用意
            List(1..<100) { _ in
                Button(action: {
// 検索バーの実験のためアクションは特になし
                }) {
                    Text("ダミー")
                        .foregroundStyle(.black)
                }
            }
            // ナビゲーションバーの固定
            .navigationBarTitleDisplayMode(.inline)
            // NavigationBarの背景色を黄色にする
            .toolbarBackground(Color.yellow, for: .navigationBar)
            /* visibility(優先される可視性)をautomaticに設定することで平常時は背景が透明で、リストの位置に
             応じて背景色が変わる。これにより、検索バーに文字を入力するときの可読性を失わずにできる*/
            .toolbarBackground(.automatic, for: .navigationBar)
            // ナビゲーションタイトルの文字サイズを変更
            .toolbar {
                // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
                ToolbarItem(placement: .principal) {
                    Text("一覧")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                }
                // ボトムバーにお店追加ボタンを配置
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        // 検索バーの実験のためアクションは特になし
                    }) {
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
        // 検索バーの実装
        .searchable(text: $inputText, prompt: Text("キーワードを入力"))
    }
}

#Preview {
    ContentView()
}
