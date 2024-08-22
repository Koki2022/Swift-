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
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
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
            // 保存ボタン
            Button(action: {
                addPhotosItem()
            }) {
                Text("保存")
            }
            // 削除ボタン
            Button(action: {
                // アラートを表示
                isShowAlert.toggle()
                
            }) {
                Text("すべて削除")
                    .foregroundColor(.red)
            }
        }
        // 画面表示時
        .onAppear {
            print("画面表示中")
            // データ件数の確認
            checkCoreDataContent()
        }
        .alert("削除しますか？", isPresented: $isShowAlert) {
            // 削除ボタン
            Button(action: {
                deleteAllPhotos() // CoreDataの情報を削除
                checkCoreDataContent() // 削除後にCore Dataの内容を確認
            }) {
                Text("OK")
            }
        }
    }
    
    // Core Dataの内容を確認する関数
    private func checkCoreDataContent() {
        // 取得したデータの件数を出力
        print("取得したデータの件数: \(fetchedPhotos.count)")
        for photo in fetchedPhotos {
            // 各ファイル名を取り出すため、fileNameアトリビュートの値を分解
            if let fileNames = photo.fileName?.components(separatedBy: ",") {
                let _ = print("CoreDataから取得したファイル名: \(fileNames)")
            }
        }
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
            // データ追加後に再度CoreDataの内容を確認
            checkCoreDataContent()
        } catch {
            print("ERROR \(error)")
        }
    }
    // CoreDataの内容全削除
    func deleteAllPhotos() {
        // 削除するファイル名を格納する配列
        var deletedFileNames: [String] = []
        // fetchedPhotos内の各photoインスタンスを格納していく
        for photo in fetchedPhotos {
            // photoインスタンスからファイル名を取り出し、削除したファイル名の配列に追加
            if let fileNames = photo.fileName?.components(separatedBy: ",") {
                // 削除するファイル名を配列に追加
                deletedFileNames.append(contentsOf: fileNames)
            }
            // ここでphotoインスタンスを削除する
            viewContext.delete(photo)
        }
        
        do {
            // 
            try viewContext.save()
            // 削除したファイル名を出力
            if !deletedFileNames.isEmpty {
                print("削除したファイル名: \(deletedFileNames)")
            } else {
                print("削除するファイルはありませんでした")
            }
        } catch {
            fatalError("セーブに失敗: \(error)")
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