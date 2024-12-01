//
//  VisitationStatus.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI

// 訪問状況は選択項目が決まっているのでenumで管理し、可読性と安全性を向上させる
enum VisitationStatus: Int16 {
    case visited = 0
    case interested = 1
    case none = 2
}
