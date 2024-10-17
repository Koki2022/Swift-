//
//  ContentView.swift
//  StateSpaceApp2
//
//  Created by 高橋昴希 on 2024/02/12.
//

import SwiftUI

struct HomeView: View {
    // お店情報のシートの状態を管理する変数
    @State private var isStoreInfoSheet: Bool = false
    // PresentingModalの状態を管理する変数
    @State private var isPresentingModal: Bool = false
    // お店編集のシートの状態を管理する状態を管理する変数
    @State private var storeEditIsShowSheet: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("ホーム画面")
                // ダミーリスト100個用意
                List(1..<100) { list in
                    Button(action: {
                        isPresentingModal.toggle()
                        isStoreInfoSheet.toggle()
                    }) {
                        Text("ダミー")
                            .foregroundStyle(.black)
                    }
                }
            }
            // 環境変数として利用する変数をトリガーとする
            .sheet(isPresented: $isPresentingModal) {
                StoreInfoView(isStoreEditSheet: $storeEditIsShowSheet)
            }
            // 子 View に環境変数を設定
            .environment(\.isPresentingModal, $isPresentingModal)
        }
    }
}


#Preview {
    HomeView()
}
