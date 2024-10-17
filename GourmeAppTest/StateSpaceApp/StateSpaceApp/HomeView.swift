//
//  ContentView.swift
//
//  Created by 高橋昴希 on 2024/02/07.
//

import SwiftUI

struct HomeView: View {
    // お店情報のシートの状態を管理する状態を管理する変数
    @State private var storeEditIsShowSheet: Bool = false
    var body: some View {
        // NavigationStackと配列パスの紐づけ
        NavigationStack {
            VStack {
                Text("ホーム画面")
                // ダミーリスト100個用意
                List(1..<100) { list in
                    NavigationLink("ダミー", destination: StoreInfoView(storeEditIsShowSheet: $storeEditIsShowSheet))
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
