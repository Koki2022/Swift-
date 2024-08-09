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
    //　ファイル名を格納する配列。
    @State private var arrayFileNames: [String] = []
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // Photosエンティティのfilanameアトリビュートへアクセス
                    ForEach(fetchedPhotos) { photo in
                        // 文字列で結合されているfilenameをカンマ区切りで分解
                        if let unwrappedFileName = photo.fileName?.components(separatedBy: ",") {
                            let _ = print("CoreData: \(unwrappedFileName)")
                            // 画面表示の際にCoreDataに保存したファイル名からUIImageを読み込む処理を実行
                            // loadImage関数の引数に代入
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
                                    print("画像が保存されました。ファイル名: \(fileName)")
                                    // ファイル名を配列に格納
                                    arrayFileNames.append(fileName)
                                    print(arrayFileNames)
                                } else {
                                    print("画像の保存に失敗しました")
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
    }
    
    // 追加ボタン押下した際にデータを保存する関数
    private func addPhotosItem() {
        let photos = Photos(context: viewContext)
        // ファイル名に格納している配列の値を文字列で結合
        let fileNameString = arrayFileNames.joined(separator: ",")
        // データを保存
        photos.fileName = fileNameString
        // 生成したインスタンスをCoreDataに保存する
        do {
            try viewContext.save()
            print("保存完了: \((photos.fileName ?? ""))")
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
    // ファイル名を取り込みUIImage型のデータを返却する関数
    func loadImage(fileName: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
}

#Preview {
    ContentView()
}
