//
//  VisitationStatus.swift
//  TestTabCoreData
//
//  Created by 高橋昴希 on 2024/10/25.
//

import SwiftUI

// rawValueで=の後の値を取れる
enum VisitationStatus: Int16 {
    case visited = 0
    case interested = 1
    case none = 3
}
