//
//  TagSelectHomeView.swift
//  GourmeListApp
//
//  Created by 高橋昴希 on 2024/04/16.
//

import SwiftUI

// TagSelectHomeView:ホーム画面用のタグ選択画面
struct TagSelectView: View {
    //　入力した文字を格納する変数
    @State private var inputTextTagSelectHomeView: String = ""
    // タグボタンの状態を管理する変数
    @State var isHomeTagButtonShown: Bool = false
    // タグボタンの状態を管理する配列
    // タグ名ごとに選択状態を管理するので構造体で管理
    @State private var isShownTagButton: [TagButtonInfo] = Array(repeating: TagButtonInfo(), count: 100)
    // タグボタンのサイズや行または列の要素数をArray文で定義
    private let columns: [GridItem] = Array(Array(repeating: .init(.fixed(120)), count: 3))
    // アラートを管理する変数
    @State private var isShownAlert: Bool = false
    var body: some View {
        //  スクロールビューの実装
        ScrollView {
            VStack {
                // 横線
                Divider()
                HStack {
                    // 右よせ
                    Spacer()
                    Button(action: {
                        // 適用されたタグがあればホーム画面の選択中のタグに表示
                    }) {
                        Text("完了")
                            .font(.system(size: 20))
                            .foregroundStyle(.red)
                            .padding(8)
                    }
                }
                // 横線
                Divider()
                // 自作検索バー
                OriginalSearchBarView(inputTextTagSelectHomeView: $inputTextTagSelectHomeView)
                // タグボタンを１行に3つずつ配置
                LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
                    // ForEach文で任意の数のダミーボタンを表示 ForEachはDataがRandomAccessCollectionに準拠し、IDがHashableに準拠し、ContentがViewに準拠する場合に使用可能。
                    // RandomAccessCollectionに準拠するためにArray文(順序付けられたランダムアクセスコレクション)
                    // 各ボタンの真偽値とindexを取得するためにenumerated()メソッドを利用し、offsetプロパティをidに渡す
                    // enumerated()メソッドはゼロから始まる整数インデックスのコレクションのインスタンスでのみindexとして使用できる。
                    // 配列の数字はindex,TagButtonInfoの真偽値をbuttonInfoに格納
                    ForEach(Array(isShownTagButton.enumerated()), id: \.offset) { index, buttonInfo in
                        Button(action: {
                            // 処理追加
                            isShownTagButton[index].isShown.toggle()
                            // indexとハッシュ値を出力
                            print("index: \(index) hasValue: \(index.hashValue)")
                            // 真偽値を出力
                            print("\(buttonInfo)")
                        }) {
                            Text("# ダミー")
                                .frame(width: 110, height: 45)
                                .font(.system(size: 18))
                                .foregroundStyle(.black)
                                .overlay(alignment: .center) {
                                    // 角丸長方形
                                    RoundedRectangle(cornerRadius: 10)
                                    // 黒縁にする
                                        .stroke(Color.black)
                                }
                            // タップしたボタンだけ背景色を黄色にする
                                .background(RoundedRectangle(cornerRadius: 10).fill(isShownTagButton[index].isShown ? Color.yellow: Color.white))
                                .padding(10)
                        }
                        // ボタンを長押しした際の挙動
                        //　削除などの役割が用意されているボタンの場合はそっちを使う?
                        .contextMenu(menuItems: {
                            Button("削除", role: .destructive) {
                                isShownAlert.toggle()
                            }
                            /* Button(action: {
                             isShownAlert.toggle()
                             }) {
                             // 赤文字にならない
                             Text("タグを削除")
                             } */
                        })
                    }
                }
                Spacer()
            }
            // インジケータを右端に表示
            .frame(maxWidth: .infinity)
        }
        // アラートの設定
        .alert("削除しますか？", isPresented: $isShownAlert) {
            Button("削除", role: .destructive) {
                // タグを削除する処理
            }
            Button("キャンセル", role: .cancel) {
                // 戻る処理
            }
        } message: {
            Text("この操作は取り消しできません")
        }
    }
}

#Preview {
    TagSelectView()
}
