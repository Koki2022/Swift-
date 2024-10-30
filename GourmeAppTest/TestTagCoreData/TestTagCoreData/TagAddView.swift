//
//  TagAddView.swift
//  TestTagCoreData
//
//  Created by 高橋昴希 on 2024/10/19.
//

import SwiftUI
import CoreData

//　TagAddView:タグ追加画面
struct TagAddView: View {
    // プロパティラッパー @FetchRequestで、データベースよりデータを取得
    @FetchRequest(entity: Tags.entity(), sortDescriptors: []
    ) private var fetchedTags: FetchedResults<Tags>
    // タグ選択画面を閉じるための動作を呼び出す変数。
    @Environment(\.dismiss) private var dismiss
    //　Core Dataの管理コンテキストにアクセス
    @Environment(\.managedObjectContext) private var viewContext
    // タグボタンのサイズや行または列の要素数をArray文で定義
    private let columns: [GridItem] = Array(Array(repeating: .init(.fixed(120)), count: 3))
    // 各タグボタンを管理する配列。タグ名ごとに選択状態を管理するので構造体で管理
    @State private var tagButtonDetail: [TagButtonDetail] = []
    // 入力したタグ名を管理する変数
    @State private var tagName: String = ""
    // タグ名入力のアラートを管理する変数
    @State private var isNameVisible: Bool = false
    // タグ名の空文字アラートを管理する変数
    @State private var isEmptyNameVisible: Bool = false
    // タグ削除の際のアラートを管理する変数
    @State private var isDeleteVisible: Bool = false
    
    var body: some View {
        //  スクロールビューの実装
        ScrollView {
            VStack {
                // 横線
                Divider()
                // 完了ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        // 選択されたタグを更新
                        
                        // viewを閉じて一覧画面へ遷移
                        dismiss()
                    }) {
                        Spacer()
                        Text("完了")
                            .font(.system(size: 20))
                            .foregroundStyle(.red)
                            .padding(8)
                    }
                }
                // 横線
                Divider()
                // タグボタンを１行に3つずつ配置
                LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
                    
                    // 1番左上にタグ追加ボタンを実装
                    Button(action: {
                        isNameVisible.toggle()
                    }) {
                        Text("タグを追加")
                            .frame(width: 110, height: 45)
                            .font(.system(size: 18))
                            .foregroundStyle(.gray)
                            .background(Color.gray.opacity(0.2))
                            .overlay(alignment: .center) {
                                // 角丸長方形
                                RoundedRectangle(cornerRadius: 10)
                                // 黒縁にする
                                    .stroke(Color.black)
                            }
                    }
                    // 作成したボタンを実装
                    ForEach(tagButtonDetail) { tag in
                        Button(action: {
                            // 長押しで削除
                        }) {
                            Text("# \(tag.name)")
                                .frame(width: 110, height: 45)
                                .font(.system(size: 18))
                                .foregroundStyle(.black)
                                .overlay(alignment: .center) {
                                    // 角丸長方形
                                    RoundedRectangle(cornerRadius: 10)
                                    // 黒縁にする
                                        .stroke(Color.black)
                                }
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                .padding(10)
                        }
                    }
                }
            }
            // 削除ボタン
            Button(action: {
                // データ全削除
            }) {
                Text("すべて削除")
                    .foregroundColor(.red)
            }
            Spacer()
            // インジケータを右端に表示
                .frame(maxWidth: .infinity)
        }
        // 画面表示時
        .onAppear {
            print("TagAddViewView表示")
        }
        // タグ名入力フィールド
        .alert("タグ名を入力してください", isPresented: $isNameVisible) {
            // 入力欄
            TextField("文字を入力してください", text: $tagName)
            // キャンセルボタン
            Button("キャンセル", role: .cancel) {
                // 処理なし
            }
            // OKボタン
            Button("OK") {
                // 空文字ならアラート
                if tagName.isEmpty {
                    isEmptyNameVisible.toggle()
                } else {
                    // 入力された文字のタグを新規作成しCoreDataへタグ名を登録
                    addTagNames(tagName: tagName)
                    // 文字をリセット
                    tagName = ""
                }
            }
        }
        // タグ名が空文字だった際の警告
        .alert("警告", isPresented: $isEmptyNameVisible) {
            // OKボタン実装
            Button("OK", role: .cancel) {
                // タグを削除する処理
            }
            // アラートポップアップ表示の際の警告
        } message: {
            Text("文字を入力してください")
        }
        // ボタン長押し時のアラート処理
        .alert("削除しますか？ ", isPresented: $isDeleteVisible) {
            // キャンセルボタン実装
            Button("キャンセル", role: .cancel) {
                // キャンセル実行時の処理
            }
            // 削除ボタン実装
            Button("削除", role: .destructive) {
                // タグを削除する処理
                
            }
            // アラートポップアップ表示の際の警告
        } message: {
            Text("この操作は取り消しできません")
        }
    }
    // 既存のタグ名がデータにないかチェックして、重複しなければcoredataにタグ名を保存
    func addTagNames(tagName: String) {
        let fetchRequest: NSFetchRequest<Tags> = Tags.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", tagName)
        
        // CoreDataへ保存
        do {
            // 設定したfetchRequestを使用してデータベースからデータを取得
            let existingTags = try viewContext.fetch(fetchRequest)
            let tag: Tags
            
            // 既存の店舗が見つかった場合、更新する。
            if let existingTag = existingTags.first {
                tag = existingTag
            } else {
                tag = Tags(context: viewContext)
            }
            print("CoreData登録前のタグ名: \(tagName)")
            // タグ名をTagsEntityのnameAttributeに格納
            tag.name = tagName
            // 保存
            try viewContext.save()
            // 新しいタグボタンを生成するためにタグ名をtagButtonDetail配列に追加
            tagButtonDetail.append(TagButtonDetail(name: tagName))
            print("CoreData登録後のタグ名: \(tagName)")
        } catch {
            print("ERROR \(error)")
        }
    }
}

#Preview {
    TagAddView()
}
