//
//  ContentView.swift
//  PhotoCoreData
//
//  Created by 高橋昴希 on 2024/08/02.
//

import SwiftUI
import CoreData
import PhotosUI

struct ContentView: View {
    // プロパティラッパー @FetchRequestで、データベースよりデータを取得
    @FetchRequest(
        entity: Photos.entity(), sortDescriptors: []
    ) private var fetchedPhotos: FetchedResults<Photos>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentation
    // アイテムを複数枚保持する配列
    @State var selectedItems: [PhotosPickerItem] = []
    // PhotosPickerItem -> UIImageに変換した複数のアイテムを格納するプロパティ
    @State var selectedImages: [UIImage] = []
    //　ファイル名を格納する配列。テスト用の固定値
    @State private var arrayFileNames: [String] = ["test1.png", "test2.png", "test3.png"]
    // アラートの状態を管理
    @State private var isShowAlert = false
    // 保存された値
    @State private var savedValue = ""
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // CoreDataからファイル名を取得して画像を表示
                    // CoreDataからPhotosエンティティを取得
                    ForEach(fetchedPhotos, id: \.self) { photo in
                        // 各ファイル名を取り出すため、fileNameアトリビュートの値を分解
                        if let fileNames = photo.fileName?.components(separatedBy: ",") {
                            let _ = print("CoreDaraから取得したファイル名: \(fileNames)")
                        }
                    }
                    // 配列内に画像が存在すれば表示
                    if !selectedImages.isEmpty {
                        // 選択された画像を表示
                        ForEach(selectedImages, id: \.self) { image in
                            PhotosPicker(selection: $selectedItems, selectionBehavior: .ordered) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:150, height: 150)
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
                    .onChange(of: selectedItems) { _, items in
                        // 非同期処理
                        Task {
                            selectedImages = []
                            arrayFileNames = []
                            for item in items {
                                guard let data = try await item.loadTransferable(type: Data.self) else { continue }
                                guard let uiImage = UIImage(data: data) else { continue }
                                selectedImages.append(uiImage)
                                
                                // 取り出した写真uiImageを、ファイル名を返す関数の引数に代入し、nilでなければファイル名をfileNameに格納
                                if let fileName = saveImageAndGetFileName(image: uiImage) {
                                    print("UIImageをストレージに保存しました。ファイル名: \(fileName)")
                                    // ファイル名を配列に格納
                                    arrayFileNames.append(fileName)
                                    print(arrayFileNames)
                                } else {
                                    print("UIImageをストレージに保存できませんでした")
                                }
                            }
                        }
                    }
                }
            }
            Button(action: {
                addPhotosItem()
            }) {
                Text("保存")
            }
        }
        .alert("保存完了", isPresented: $isShowAlert) {
            Button("OK") {}
        } message: {
            Text("保存された値: \(savedValue)")
        }
        .onAppear()
    }
    
    // 追加ボタン押下した際にデータを保存する関数
    private func addPhotosItem() {
        let photos = Photos(context: viewContext)
        // ファイル名に格納している配列の値を文字列で結合
        let fileNameString = arrayFileNames.joined(separator: ",")
        // 登録直前のデータ確認
        print("登録直前のデータ: \(fileNameString)")
        // データを保存
        photos.fileName = fileNameString
        // 生成したインスタンスをCoreDataに保存する
        do {
            try viewContext.save()
            // CoreData登録直後のデータ確認
            print("CoreData登録直後のデータ: \(photos.fileName ?? "データなし")")
            // 保存された値を記録
            savedValue = fileNameString
            // アラートを表示
            isShowAlert.toggle()
        } catch {
            print("ERROR \(error)")
        }
    }
    // UIImageをストレージに保存し、ファイル名を返す関数
    private func saveImageAndGetFileName(image: UIImage) -> String? {
        // ファイル名の重複を避けるためUUIDを生成してファイル名に使用.
        let uuid = UUID().uuidString
        let fileName = "\(uuid).png"
        
        // 画像をPNGデータに変換
        guard let data = image.pngData() else {
            return nil
        }
        
        // ドキュメントディレクトリのURLを取得
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // 保存するファイルのフルパスを作成
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            // データをファイルに書き込む
            try data.write(to: fileURL)
            
            // 保存したファイル名を返す
            return fileName
        } catch {
            print("画像の保存に失敗しました: \(error)")
            return nil
        }
    }
}

#Preview {
    ContentView()
}
