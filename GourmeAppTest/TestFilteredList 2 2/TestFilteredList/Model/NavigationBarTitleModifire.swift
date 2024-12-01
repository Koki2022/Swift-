//
//  NavigationBarTitleModifire.swift
//  TestFilteredList
//
//  Created by 高橋昴希 on 2024/11/24.
//

import SwiftUI

// NavigationBarTitleModifire:ナビゲーションタイトルのスタイルをまとめた構造体
struct NavigationBarTitleModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .fontWeight(.heavy)
    }
}

extension View {
    func navigationBarTitleStyle() -> some View {
        self.modifier(NavigationBarTitleModifire())
    }
}
