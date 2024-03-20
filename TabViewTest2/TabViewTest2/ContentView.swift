//
//  ContentView.swift
//  TabViewTest2
//
//  Created by 高橋昴希 on 2024/03/06.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var canSwipe: Bool = false

    let list: [String] = ["Test1", "Test2", "Test3"]

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            TopTabView(list: list, selectedTab: $selectedTab)
            TabView(selection: $selectedTab,
                    content: {
                Text("FirstView")
                    .tag(0)
                Text("SecondView")
                    .tag(1)
                Text("ThirdView")
                    .tag(2)
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .disabled(!canSwipe)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Test")
    }
}

#Preview {
    ContentView()
}
