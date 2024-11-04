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
    @FetchRequest(entity: Stores.entity(), sortDescriptors: []
    ) private var fetchedStores: FetchedResults<Stores>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentation
    // タグ選択画面を閉じるための動作を呼び出す変数。
    @Environment(\.dismiss) private var dismiss
    // お店検索画面シートの状態を管理する変数。
    @State private var isStoreSearchVisible: Bool = false
    // タグ選択画面のシートの状態を管理する変数。
    @State private var isTagSelectionVisible: Bool = false
    // 選択されたタグを格納するための配列
    @State private var selectedTags: [String] = []
    // CoreDataの選択したタグ名の情報を管理するための配列
    @State private var arraySelectedTag: [String] = []
    
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
                                ForEach(selectedTags, id: \.self) { tag in
                                    Text("# \(tag)")
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
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
                    // 削除ボタン
                    Button(action: {
                        // データ全削除
                        deleteAllSelectedTag(fetchedStores: fetchedStores, viewContext: viewContext)
                    }) {
                        Text("すべて削除")
                            .foregroundColor(.red)
                    }
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
                            // 選択したタグをCoreDataに登録
                            addSelectedTags(viewContext: viewContext)
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
            // 選択したタグのデータを取得
            loadSelectedTags(fetchedStores: fetchedStores)
        }
        // タグ選択画面を表示する際の設定
        .sheet(isPresented: $isTagSelectionVisible) {
            // タグ選択画面を表示
            TagAddView(selectedTags: $selectedTags)
        }
    }
    // 画面表示時にcoredataから選択したタグを読み取る
    func loadSelectedTags(fetchedStores: FetchedResults<Stores>) {
        print("loadSelectedTags実行前")
        // 空の配列用意
        var newArraySelectedTags: [String] = []
        // CoreDataからタグデータを取得
        for store in fetchedStores {
            // 配列のタグ名をを分解
            if let tags = store.selectedTag?.components(separatedBy: ",") {
               // タグを取り出す
                for tag in tags {
                    newArraySelectedTags.append(tag)
                }
            }
        }
        // 取り出したデータ
        print("取り出したデータ: \(newArraySelectedTags)")
        // selectedTagに取り出したタグを格納
        selectedTags = newArraySelectedTags
    }
    // 選択したタグを保存する関数
    func addSelectedTags(viewContext: NSManagedObjectContext) {
        // 配列に選択したタグ名を格納
        for tag in selectedTags {
            arraySelectedTag.append(tag)
        }
        // タグ名を結合
        let tagNameString = arraySelectedTag.joined(separator: ",")
        print("結合後の選択したタグ名: \(tagNameString)")
        // 既存のエントリをチェックして、ボタン押下の度に新エントリが作成されるのを防ぐ
        let existingStore = fetchedStores.first
        // エントリが存在してれば、エントリを更新
        if let store = existingStore {
            store.selectedTag = tagNameString
            print("既に存在するタグです")
        } else {
            // エントリが存在してなければ、エントリを作成
            let store = Stores(context: viewContext)
            store.selectedTag = tagNameString
            print("登録前の選択したタグ名: \(tagNameString)")
        }
        // coredataに保存
        do {
            try viewContext.save()
            print("登録後の選択したタグ名: \(tagNameString)")
        } catch {
            print("CoreData ERROR \(error)")
        }
    }
    // データをすべて削除する関数
    func deleteAllSelectedTag(fetchedStores: FetchedResults<Stores>, viewContext: NSManagedObjectContext) {
        // CoreDataの情報を取り出す
        for store in fetchedStores {
            viewContext.delete(store)
        }
        // 変更を保存
        do {
            try viewContext.save()
            print("StoresEntityのデータを全て削除しました")
            // 選択したタグの配列を削除
            arraySelectedTag.removeAll()
            // 選択したタグも削除
            selectedTags.removeAll()
        } catch {
            print("タグの削除中にエラーが発生しました: \(error)")
        }
    }
}

#Preview {
    RegistrationView()
}
