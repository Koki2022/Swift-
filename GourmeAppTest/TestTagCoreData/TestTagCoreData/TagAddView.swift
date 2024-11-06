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
    // 選択されたタグを格納するための配列
    @Binding var selectedTags: [String]
    // タグ名入力のアラートを管理する変数
    @State private var isNameVisible: Bool = false
    // 各タグボタンを管理する配列。タグ名ごとに選択状態を管理するので構造体で管理
    @State private var arrayTagButtonDetail: [TagButtonDetail] = []
    // 削除対象のタグ名を管理する変数
    @State private var tagToDelete: String?
    // タグ削除の際のアラートを管理する変数
    @State private var isDeleteNameVisible = false
    // 入力したタグ名を管理する変数
    @State private var tagName: String = ""
    // タグ名の空文字アラートを管理する変数
    @State private var isEmptyNameVisible: Bool = false
    // タグ削除の際のアラートを管理する変数
    @State private var isSameNameVisible: Bool = false
    // CoreDataのタグ名の情報を管理するための配列
    @State private var arrayTagNames: [String] = []
    
    
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
                    ForEach(arrayTagButtonDetail) { tag in
                        Button(action: {
                            // arrayTagButtonDetail配列の中で{ $0.id == tag.id }がtrueを返す最初の要素のインデックスを探す
                            if let index = arrayTagButtonDetail.firstIndex(where: { $0.id == tag.id }) {
                                // タップしたタグの選択状態を変更
                                arrayTagButtonDetail[index].isSelected.toggle()
                                print("タップしたタグの情報とtagIDの確認: \(arrayTagButtonDetail[index]), \(tag.id)")
                                
                                if arrayTagButtonDetail[index].isSelected {
                                    // 選択状態なら選択したタグの配列に格納
                                    selectedTags.append(tag.name)
                                } else {
                                    // 再タップで選択状態を解除(falseに)するため配列から削除
                                    selectedTags.removeAll { $0 == tag.name }
                                }
                            }
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
                            // タグの選択状態がtrueの場合は背景色が黄色になる
                                .background(RoundedRectangle(cornerRadius: 10).fill(tag.isSelected ? Color.yellow: Color.white))
                                .padding(10)
                        }
                        // 長押しした際の処理
                        .contextMenu {
                            Button(role: .destructive) {
                                // 削除対象のタグ名を一時的に保持するために使用
                                tagToDelete = tag.name
                                // アラート表示
                                isDeleteNameVisible.toggle()
                            } label: {
                                Label("削除", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            // 削除ボタン
            Button(action: {
                // データ全削除
                deleteAllTag(fetchedTags: fetchedTags, viewContext: viewContext)
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
            // 作成したタグの名前を読み取る
            loadTagNames(fetchedTags: fetchedTags)
            // enumerated() で配列の要素を更新
            for (index, tag) in arrayTagButtonDetail.enumerated() {
                // selectedTagsにあるタグは選択状態をtrueにする
                arrayTagButtonDetail[index].isSelected = selectedTags.contains(tag.name)
            }
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
        // 同じタグ名が存在する場合のアラート
        .alert("同じタグ名が既に存在します", isPresented: $isSameNameVisible) {
            // OKボタン実装
            Button("OK", role: .cancel) {
                // タグを削除する処理
            }
        }
        // ボタン長押し時のアラート処理
        .alert("タグを削除", isPresented: $isDeleteNameVisible, presenting: tagToDelete) { tagName in
            Button("削除", role: .destructive) {
                // タグ削除
                deleteTag(tagName: tagName)
            }
            Button("キャンセル", role: .cancel) {}
        } message: { tagName in
            Text("'\(tagName)'を削除してもよろしいですか？")
        }
    }
    // 画面表示時にcoredataからタグ情報を読み取る
    func loadTagNames(fetchedTags: FetchedResults<Tags>) {
        print("loadTagNames実行前")
        var newArrayTagButtonInfo: [TagButtonDetail] = []
        var newArrayTagNames: [String] = []
        
        // CoreDataからタグ名を管理するデータを取得
        for tag in fetchedTags {
            // 配列のタグ名を分解する
            if let tagNames = tag.name?.components(separatedBy: ",") {
                // 分解したタグ名を取り出す
                for tagName in tagNames {
                    // タグ名が存在、またタグ名の配列と取り出したタグ名が重複していなければnewArrayTagButtonInfoとnewArrayTagNamesに追加
                    if !tagName.isEmpty && !newArrayTagNames.contains(tagName) {
                        newArrayTagButtonInfo.append(TagButtonDetail(name: tagName))
                        newArrayTagNames.append(tagName)
                    }
                }
            }
        }
        // UIを更新
        arrayTagNames = newArrayTagNames
        arrayTagButtonDetail = newArrayTagButtonInfo
        print("loadTagNames実行後: \(arrayTagButtonDetail)")
    }
    // タグ名をCoreDataに登録し、新しいタグボタンを作成するための関数
    func addTagNames(tagName: String) {
        // CoreDataからTagsエンティティの全てのインスタンスを取得する
        let fetchRequest: NSFetchRequest<Tags> = Tags.fetchRequest()
        // nameアトリビュートがtagNameの値と完全に一致するエンティティのみを取得する
        fetchRequest.predicate = NSPredicate(format: "name == %@", tagName)
        
        // CoreDataへ保存する際の処理
        do {
            // 設定したfetchRequestを使用してデータベースからデータを取得
            let existingTags = try viewContext.fetch(fetchRequest)
            
            // 既存のタグが見つかった場合は、新しいタグを作成しない
            if !arrayTagNames.contains(tagName) && existingTags.isEmpty  {
                // 新しいエントリを作成してデータを保存
                let newTag = Tags(context: viewContext)
                // 配列にタグ名を格納
                arrayTagNames.append(tagName)
                print(arrayTagNames)
                // タグ名を格納している配列の値を文字列で結合
                let tagNameString = arrayTagNames.joined(separator: ",")
                print("CoreData登録前のタグ名: \(tagNameString)")
                // 結合したタグ名をTagsEntityのnameAttributeに格納
                newTag.name = tagNameString
                // 保存
                try viewContext.save()
                print("CoreData登録後のタグ名: \(tagNameString)")
                // 新しいタグボタンを生成するためにタグ名をtagButtonDetail配列に追加
                arrayTagButtonDetail.append(TagButtonDetail(name: tagName))
            } else {
                isSameNameVisible.toggle()
                print("タグ '\(tagName)' は既に存在します。")
            }
        } catch {
            print("ERROR \(error)")
        }
    }
    func deleteTag(tagName: String) {
        // CoreDataからタグを削除
        for tag in fetchedTags {
            // タグ名を分割
            if let names = tag.name?.components(separatedBy: ",") {
                // $0は配列の各要素。削除対象のタグ名ではない他の要素で値を結合する
                let updatedNames = names.filter { $0 != tagName }
                tag.name = updatedNames.joined(separator: ",")
            }
        }
        
        // それぞれtagNameと一致する配列の要素を削除する
        arrayTagButtonDetail.removeAll { $0.name == tagName }
        arrayTagNames.removeAll { $0 == tagName }
        selectedTags.removeAll { $0 == tagName }
        
        // 変更を保存
        do {
            try viewContext.save()
            print("タグ '\(tagName)' を削除しました")
            print("削除後のタグ確認: \(arrayTagNames)")
        } catch {
            print("タグの削除中にエラーが発生しました: \(error)")
        }
    }
    // データをすべて削除する関数
    func deleteAllTag(fetchedTags: FetchedResults<Tags>, viewContext: NSManagedObjectContext) {
        // CoreDataの情報を取り出す
        for tag in fetchedTags {
            viewContext.delete(tag)
        }
        // 変更を保存
        do {
            try viewContext.save()
            print("TagsEntityの全てのデータを削除しました")
            // タグ名の配列を削除
            arrayTagNames.removeAll()
            // ボタンを削除するために配列も削除
            arrayTagButtonDetail.removeAll()
            // 選択したタグも削除
            selectedTags.removeAll()
        } catch {
            print("タグの削除中にエラーが発生しました: \(error)")
        }
    }
    
}

#Preview {
    TagAddView(selectedTags: .constant([]))
}
