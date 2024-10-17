//
//  EnvironmentModel.swift
//  StateSpaceApp2
//
//  Created by 高橋昴希 on 2024/02/12.
//

import SwiftUI

// 閉じる・開くの制御なので Bool
struct PresentingModalKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}
// 自作環境変数
extension EnvironmentValues {
    var isPresentingModal: Binding<Bool> {
        get { self[PresentingModalKey.self] }
        set { self[PresentingModalKey.self] = newValue }
    }
}
