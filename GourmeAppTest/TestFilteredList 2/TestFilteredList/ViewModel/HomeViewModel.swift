//
//  HomeViewModel.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    // 訪問状況を管理する変数
    @Published var visitationStatus: VisitationStatus = .visited
    // ホーム画面でユーザーが選択したタグを保持
    @Published var userSelectedTags: [String] = []
    // CoreDataから取得したお店のデータ
    @Published var coreDataFetchedStores: [Stores] = []
    
    // フィルタリングされたお店リストを返す計算プロパティ
    var filteredStores: [Stores] {
        if userSelectedTags.isEmpty {
            print("タグ未選択のため全表示: \(coreDataFetchedStores)")
            return coreDataFetchedStores // タグ未選択の場合は全件表示
        }
        return coreDataFetchedStores.filter { store in
            // CoreDataのお店が持つタグをカンマ区切り文字列から配列に変換
            guard let storeTagsString = store.selectedTag else { return false }
            let storeTags = storeTagsString.components(separatedBy: ",") // カンマで分割
            print("ユーザーが選択したタグ: \(storeTags)")
            // ユーザーが選択したタグがすべて含まれているか確認（AND条件）
            return userSelectedTags.allSatisfy { storeTags.contains($0) }
        }
    }
}
