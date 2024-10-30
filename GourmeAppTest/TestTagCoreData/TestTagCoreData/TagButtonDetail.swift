//
//  TagButtonDetail.swift
//  TestTagCoreData
//
//  Created by 高橋昴希 on 2024/10/19.
//

import Foundation

// 作成した各タグボタンの情報を格納する構造体
struct TagButtonDetail: Identifiable {
    let id = UUID()
    var name: String = ""
    var isSelected: Bool = false
}
