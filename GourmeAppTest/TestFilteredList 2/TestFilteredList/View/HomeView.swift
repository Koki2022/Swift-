//
//  ContentView.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import CoreData

//　HomeView:お店一覧画面(ホーム画面)
struct HomeView: View {
    // SwiftUIの環境からmanagedObjectContextを取得してCoreDataの操作を行う
    @Environment(\.managedObjectContext) private var viewContext
    // 訪問日順でソート、%iで数値の値を検索しフィルタリング
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [], predicate: (NSPredicate(format: "visitationStatus == %i", 0))) private var fetchedStores: FetchedResults<Stores>
    // 変数の順序は関連性に基づくグループ、プロパティラッパーの種類、アクセス修飾子、使用される順を意識
    // SHomeViewModelクラスをインスタンス化
    @StateObject private var viewModel = HomeViewModel()
    // 画面遷移全体のナビゲーションの状態を管理する配列パス。private変数の中で一番先に使用される変数なので一番上に記載。
    @State private var navigatePath: [HomeNavigatePath] = []
    // ホーム画面用のタグ選択画面のシートの状態を管理する変数。Bool型は先にisをつけると分かりやすい
    @State private var isTagSelectionVisible: Bool = false
    // 選択したタグを管理する変数
    @State private var selectedTags: [String] = []
    // お店登録画面のシートの状態を管理する変数。
    @State private var isStoreRegistrationVisible: Bool = false
    // 入力された内容を反映する変数
    @State private var text: String = ""
    
    
    var body: some View {
        // NavigationStackと配列パスの紐付け
        NavigationStack(path: $navigatePath) {
            VStack {
                // #とタブボタンの実装
                HStack {
                    Spacer()
                    // タグボタン
                    Button(action: {
                        // ハーフモーダルでタグ選択画面のシートを表示
                        isTagSelectionVisible.toggle()
                    }) {
                        Text("#")
                            .font(.system(size: 20))
                            .frame(width: 50, height: 30)
                            .border(Color.gray)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(10)
                    }
                    Spacer()
                    // 行ったリストと気になるリストのタブ作成
                    Picker("行った気になるを選択", selection: $viewModel.visitationStatus) {
                        Text("行った").tag(VisitationStatus.visited)
                        Text("気になる").tag(VisitationStatus.interested)
                    }
                    .pickerStyle(.segmented)
                    Spacer()
                }
                // 選択中のタグを表示する欄
                if selectedTags.isEmpty {
                    // 選択中のタグ
                    HStack {
                        Spacer()
                        Text("選択中のタグなし")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                } else {
                    // TagSelectionViewで選択したタグを表示
                    HStack {
                        Spacer()
                        Text("選択中のタグ")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(selectedTags, id: \.self) { tag in
                                    Text("\(tag)")
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        Spacer()
                        // タグをまとめて削除するためのxボタン
                        Button(action: {
                            selectedTags.removeAll()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                }
                Spacer()
                
                // リストがない場合は作成しようと表示
                if fetchedStores.isEmpty {
                    Text("お店リストを作成しよう！")
                    Spacer()
                } else {
                    List {
                        // ユーザが選択したタグに応じてフィルタリングされたリストを表示
                        ForEach(viewModel.filteredStores) { store in
                            HStack {
                                Button(action: {
                                    // お店情報画面へ遷移
                                    navigatePath.append(.storeInfoView)
                                }) {
                                    Text("\(store.name ?? "店名なし")")
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            // 画面表示の際にデータを格納
            .onAppear(perform: updateViewModelData)
            /* StoreRegistrationViewシートを閉じてもonAppearは呼び出されないので、isStoreRegistrationVisibleの値を監視してシート非表示(false)の際,userSelectedTagsとcoreDataFetchedStoresにデータを渡す */
            .onChange(of: isStoreRegistrationVisible) { _, isVisible in
                if !isVisible {
                    print("StoreRegistrationViewから遷移完了")
                    //
                    updateViewModelData()
                }
            } 
            // 選択しているタグの値を監視
            .onChange(of: selectedTags) { _, newTags in
                print("タグ選択後の値を確認: \(newTags)")
                updateViewModelData()
            }
            // onChangeを使用してfetchedStoresのpredicateを更新
            .onChange(of: viewModel.visitationStatus) { _, newStatus in
                // visitationStatusが変更された際に動的にフィルタリング
                fetchedStores.nsPredicate = NSPredicate(format: "visitationStatus == %i", newStatus.rawValue)
                updateViewModelData()
            }
            // 遷移先のビューをそれぞれ定義
            .navigationDestination(for: HomeNavigatePath.self) { value in
                switch value {
                    // お店情報画面のビューを定義
                case .storeInfoView:
                    StoreOverview(navigatePath: $navigatePath)
                    // お店編集画面のビューを定義
                case .storeEditView:
                    StoreEditView(navigatePath: $navigatePath)
                }
            }
            // NavigationBarを固定する
            .navigationBarTitleDisplayMode(.inline)
            // ナビゲーションタイトルの文字サイズを変更
            .toolbar {
                // toolbarモディファイアにToolbarItem構造体を渡しprincipal(中央配置)を指定
                ToolbarItem(placement: .principal) {
                    Text("一覧")
                        .navigationBarTitleStyle()
                }
                // ボトムバーにお店を追加ボタン作成
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        // お店登録画面をシート表示
                        isStoreRegistrationVisible.toggle()
                    }) {
                        Text("お店を追加")
                            .navigationBottomBarStyle()
                    }
                }
            }
        }
        // 店名検索バーの実装
        .searchable(text: $text, prompt: Text("店名を入力"))
        // タグ選択画面を表示する際の設定
        .sheet(isPresented: $isTagSelectionVisible) {
            // タグ選択画面を表示
            TagSelectionView(selectedTags: $selectedTags)
            // ハーフモーダルで表示。全画面とハーフに可変できるようにする。
                .presentationDetents([
                    .medium,
                    .large
                ])
        }
        // お店登録画面をフルスクリーンで表示
        .fullScreenCover(isPresented: $isStoreRegistrationVisible) {
            StoreRegistrationView()
        }
    }
    // ViewModelのデータを更新する関数
    func updateViewModelData() {
        viewModel.coreDataFetchedStores = Array(fetchedStores)
        viewModel.userSelectedTags = selectedTags
        print("fetchedStores件数: \(fetchedStores.count)")
    }
}

#Preview {
    HomeView()
}
