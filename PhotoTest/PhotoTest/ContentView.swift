//
//  ContentView.swift
//  PhotoTest
//
//  Created by 高橋昴希 on 2024/07/19.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    // アイテムを複数枚保持する配列
    @State var selectedItems: [PhotosPickerItem] = []
    // PhotosPickerItem -> UIImageに変換した複数のアイテムを格納するプロパティ
    @State var selectedImages: [UIImage] = []
    var body: some View {
        // 横スクロール
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // 配列内に画像が存在すれば表示
                if !selectedImages.isEmpty {
                    // 選択された画像を表示
                    ForEach(selectedImages, id: \.self) { image in
                        PhotosPicker(selection: $selectedItems, selectionBehavior: .ordered) {
                            Image(uiImage: image)
                            // 画像サイズを変更可能にする
                                .resizable()
                            // アスペクト比を維持しながら指定されたフレームを埋める
                                .scaledToFill()
                                .frame(width:150, height: 150)
                            // フレームからはみ出た部分を切り取る
                                .clipped()
                                .padding(5)
                        }
                    }
                }
                PhotosPicker(selection: $selectedItems, selectionBehavior: .ordered) {
                    Text("+")
                        .font(.system(size: 30))
                        .frame(width: 150, height: 150)
                        .foregroundStyle(Color.black)
                        .background(Color.gray.opacity(0.4))
                        .padding([.leading, .trailing], 5)
                }
                // onChangeでPhotosPickerItem型プロパティを監視
                // onChange(of:perform:)非推奨、onChange(of:initial:_:)で0か２つの入力パラメータを用意
                .onChange(of: selectedItems) { selectedItems, items in
                    // 非同期処理
                    Task {
                        selectedImages = []
                        for item in items {
                            guard let data = try await item.loadTransferable(type: Data.self) else { continue }
                            guard let uiImage = UIImage(data: data) else { continue }
                            selectedImages.append(uiImage)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
