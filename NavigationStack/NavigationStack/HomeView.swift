//
//  ContentView.swift
//  NavigationStack
//
//  Created by 高橋昴希 on 2024/02/07.
//

import SwiftUI

struct HomeView: View {
    // enumをデータ型に指定した配列パス
    @State private var navigatePath: [samplePath] = []
    var body: some View {
        // NavigationStackと配列パスの紐づけ
        NavigationStack(path: $navigatePath) {
            VStack {
                Text("ホーム画面")
                // ダミーリスト100個用意
                List(1..<100) { list in
                    Button(action: {
                        // 次のビューへ遷移(お店情報画面へ遷移)
                        navigatePath.append(.storeInfo)
                    }) {
                        Text("ダミー")
                            .foregroundStyle(.black)
                    }
                }
            }
            // caseで遷移先のビューを分岐
            .navigationDestination(for: samplePath.self) { value in
                switch value {
                case .storeInfo:
                    StoreInfoView(navigatePath: $navigatePath)
                case .storEdit:
                    StoreEditView(navigatePath: $navigatePath)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
