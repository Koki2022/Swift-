//
//  GoneHomeView.swift
//  TopTabViewTest
//
//  Created by 高橋昴希 on 2024/03/06.
//

import SwiftUI

//　HomeView:お店一覧画面(ホーム画面)
struct GoneHomeView: View {
    // 変数の順序は関連性に基づくグループ、プロパティラッパーの種類、アクセス修飾子、使用される順を意識
    // 入力された内容を反映する変数
    @State private var homeSearchInputText: String = ""
    // タグ選択画面のシートの状態を管理する変数。Bool型は先にisをつけると分かりやすい
    @State private var isTagSelectSheetShown: Bool = false
    var body: some View {
        // NavigationStackと配列パスの紐付け
        NavigationStack {
            VStack {
                HStack {
                    // タグボタン
                    Button(action: {
                        // 遷移なし
                    }) {
                        Text("タグ")
                            .font(.system(size: 20))
                            .frame(width: 80, height: 40)
                            .border(Color.gray)
                            .foregroundStyle(.black)
                            .background(Color.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(10)
                    }
                    // タグボタンを左端に配置
                    Spacer()
                }
                // ダミーリスト100個用意
                List(1..<100) { _ in
                    HStack {
                        // 各リストの左側に自分が撮影した写真を載せる
                        Image("")
                        // サイズ変更モードに設定
                            .resizable()
                        // 写真をリストのビューにフィットするようにアスペクト比を維持
                            .aspectRatio(contentMode: .fit)
                        // 枠の高さを調整
                            .frame(height: 60)
                        Button(action: {
                            // 検証用のため遷移なし
                        }) {
                            Text("ダミー")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            // NavigationBarを固定する
            .navigationBarTitleDisplayMode(.inline)
            // ナビゲーションタイトルの文字サイズを変更
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        // 検証用のため遷移なし
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
        .searchable(text: $homeSearchInputText, prompt: Text("キーワードを入力"))
    }
}

#Preview {
    GoneHomeView()
}
