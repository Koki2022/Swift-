//
//  SwiftUIView.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI

// 画面遷移全体の配列パスとして扱う列挙型。UpperCamelCaseで記載し直しました。
// storeRegistrationView,storeSearchViewはシート表示のため削除
enum HomeNavigatePath: Hashable {
    case storeInfoView(store: Stores)
    case storeEditView
}
