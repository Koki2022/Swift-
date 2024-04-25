//
//  IsShownTagButton.swift
//  TagButtonTest
//
//  Created by 高橋昴希 on 2024/04/23.
//

import Foundation

// FoeEach文での処理時にHashableに準拠する必要あり
struct TagButtonInfo: Hashable {
    var isShown: Bool = false
}
