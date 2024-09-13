//
//  StoreEditView.swift
//  GourmeListApp
//
//  Created by 高橋昴希 on 2024/01/30.
//

import SwiftUI

//　StoreEditView:お店編集画面
struct StoreEditView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("お店情報編集画面")
            Spacer()
            // お店編集画面を閉じて一覧画面へ遷移
            NavigationLink(destination: HomeView()) {
                Text("お店リストに追加する")
                    .frame(width: 350, height: 70)
                    .foregroundStyle(.white)
                    .background(Color.red)
                    .clipShape(.buttonBorder)
                    .padding(10)
            }
        }
    }
}

#Preview {
    StoreEditView()
}
