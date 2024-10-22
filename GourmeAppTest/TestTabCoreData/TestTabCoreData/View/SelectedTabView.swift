//
//  SelectedTabView.swift
//  TestTabCoreData
//
//  Created by 高橋昴希 on 2024/10/21.
//

import SwiftUI
import CoreData

struct SelectedTabView: View {
    @FetchRequest(entity: Stores.entity(), sortDescriptors: [])
    private var fetchedStores: FetchedResults<Stores>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SelectedTabViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("お店の名前")
                    .foregroundStyle(Color.gray)
                TextField("", text: $viewModel.storeName)
                    .frame(maxWidth: .infinity)
            }
            HStack {
                Text("訪問状況")
                
                Picker("訪問状況を選択", selection: $viewModel.tabNumber) {
                    Text("行った").tag(0)
                    Text("気になる").tag(1)
                }
                Spacer()
            }
            Button(action: {
                // お店情報をCoreDataに追加
                viewModel.saveStoreInfo(viewContext: viewContext)
                // 追加後のデータ確認
                viewModel.checkStoreDetailData(fetchedStores: fetchedStores)
                dismiss()
            }) {
                Text("お店リストに追加")
            }
        }
    }
    
    
}

#Preview {
    SelectedTabView()
}
