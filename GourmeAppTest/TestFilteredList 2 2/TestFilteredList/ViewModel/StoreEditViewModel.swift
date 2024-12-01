//
//  StoreEditViewModel.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI
import CoreData

class StoreEditViewModel: ObservableObject {
    // @Published:ObservedObjectプロパティに準拠したクラス内部のプロパティを監視し、複数のviewに対して自動通知を行うことができる
    @Published var editViewDetailData: StoreDetailData = StoreDetailData()
    // 訪問状態を管理する変数
    @Published var visitationStatus: VisitationStatus = .visited

}
