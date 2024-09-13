//
//  StoreSearchView.swift
//  GourmeListApp
//
//  Created by 高橋昴希 on 2024/01/25.
//

import SwiftUI

//　StoreSearchView:お店検索画面
struct StoreSearchView: View {
    // 入力された内容を反映する変数
    @State private var storeSearchInputText: String = ""
    // お店検索画面を閉じるための動作を呼び出す変数
    @Environment (\.dismiss) private var storeSearchDismiss
    var body: some View {
        // リスト表示にタイトルをつけるためNavigationStackを用意
        NavigationStack {
            VStack {
                // お店検索時のキーワドを入力する欄
                TextField("🔍キーワードを入力してください", text: $storeSearchInputText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Spacer()
                // ダミーリスト100個用意
                List (1..<100) { shopList in
                    // お店登録画面へ遷移
                    NavigationLink("ダミーデータ", destination: StoreRegistrationView())
                }
            }
            // NavigationBarを固定する
                .navigationBarTitleDisplayMode(.inline)
            // NavigationBarの背景色を黄色にする
                .toolbarBackground(Color.yellow, for: .navigationBar)
            // 常時背景色が見えるようにする
                .toolbarBackground(.visible, for: .navigationBar)
            // ナビゲーションタイトルの文字サイズを変更
            .toolbar {
                // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
                ToolbarItem(placement: .principal) {
                    Text("お店の検索")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                }
                // toolbarの左側に戻るボタンを配置しタップしたらお店一覧画面へ遷移する
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // 処理追加
                        storeSearchDismiss()
                    }) {
                        Text("戻る")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    StoreSearchView()
}
