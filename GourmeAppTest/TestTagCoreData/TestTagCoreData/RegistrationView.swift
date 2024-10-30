//
//  ContentView.swift
//  TestTagCoreData
//
//  Created by 高橋昴希 on 2024/10/19.
//

import SwiftUI
import CoreData

// StoreInfoEditorView:　お店情報の表示・編集をする画面
struct RegistrationView: View {
    // プロパティラッパー @FetchRequestで、データベースよりデータを取得
    @FetchRequest(entity: Tags.entity(), sortDescriptors: []
    ) private var fetchedTags: FetchedResults<Tags>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentation
    // タグ選択画面を閉じるための動作を呼び出す変数。
    @Environment(\.dismiss) private var dismiss
    // お店検索画面シートの状態を管理する変数。
    @State var isStoreSearchVisible: Bool = false
    // タグ選択画面のシートの状態を管理する変数。
    @State var isTagSelectionVisible: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Divider()
                    // タグ欄
                    HStack {
                        Text("タグ")
                            .frame(width: 80)
                            .foregroundStyle(Color.gray)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                // TagAddViewで選択されたタグを表示
                            }
                        }
                        Spacer()
                        Button(action: {
                            // タグ選択画面へ遷移
                            isTagSelectionVisible.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                    Divider()
                        .padding(.horizontal, 16)
                }
                .navigationTitle("登録")
                // ナビゲーションタイトルの文字サイズを変更
                .toolbar {
                    // ナビゲーション バーの先端に戻るボタン配置
                    ToolbarItem(placement: .cancellationAction) {
                        // 戻るボタン
                        Button(action: {
                            // ホーム画面に戻る
                            dismiss()
                        }) {
                            Text("戻る")
                        }
                    }
                    // ボトムバーにお店リストに追加ボタンを作成
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            // ホーム画面に遷移
                            dismiss()
                        }) {
                            Text("お店リストに追加")
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
        // 画面表示時
        .onAppear {
            print("RegistrationView表示")
            
        }
        // タグ選択画面を表示する際の設定
        .sheet(isPresented: $isTagSelectionVisible) {
            // タグ選択画面を表示
            TagAddView()
        }
    }
}

#Preview {
    RegistrationView()
}
