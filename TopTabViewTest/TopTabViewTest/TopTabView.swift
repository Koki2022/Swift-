//
//  TopTabView.swift
//  TopTabViewTest
//
//  Created by 高橋昴希 on 2024/03/06.
//

import SwiftUI

struct TopTabView: View {
    let tabName: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            // 配列の要素数を取得してタブに反映する
            ForEach(0 ..< tabName.count, id: \.self) { row in
                Button(action: {
                    // タブの視覚的な遷移を実現する
                    withAnimation {
                        selectedTab = row
                    }
                }) {
                    // 以下,タブのデザイン
                    VStack(spacing: 0) {
                        HStack {
                            //　タブネームの配列を取得
                            Text(tabName[row])
                                .font(Font.system(size: 18, weight: .semibold))
                            // 主要コンテンツにに使用する色は.primaryを採用
                                .foregroundColor(Color.primary)
                        }
                        //
                        .frame(
                            width: (UIScreen.main.bounds.width / CGFloat(tabName.count)),
                            height: 48 - 3
                        )
                        // 
                        Rectangle()
                            .fill(selectedTab == row ? Color.green : Color.clear)
                            .frame(height: 3)
                    }
                    .fixedSize()
                }
            }
        }
        .frame(height: 48)
        .background(Color.white)
        //　compositingGroupで上記のコードを1つのパーツにする
        .compositingGroup()
        .shadow(color: .primary.opacity(0.2), radius: 3, x: 4, y: 4)
    }
}

#Preview {
    TopTabView(tabName: ["行った", "気になる"],selectedTab: .constant(0))
}
