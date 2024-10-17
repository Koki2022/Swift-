//
//  ContentView.swift
//  TabViewTest
//
//  Created by 高橋昴希 on 2024/06/13.
//

import SwiftUI

struct ContentView: View {
    // 画像のリスト
    private let photos = ["cymbal", "guitar"]
    // 選択したタブのインデックス
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            // indicesで配列の要素数の範囲を取得?
            ForEach(photos.indices, id: \.self) { index in
                Button(action: {
                    print(photos.indices) // 0..<2
                    print(index) // cymbal:0 guitar:1
                }) {
                    
                    // 画像表示
                    Image(photos[index])
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity)
                        .tag(index)
                        .background(.red)
                }
            }
        }
        // スライド表示スタイル
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    ContentView()
}
