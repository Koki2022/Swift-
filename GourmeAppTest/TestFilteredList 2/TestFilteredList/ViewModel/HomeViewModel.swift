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
}
