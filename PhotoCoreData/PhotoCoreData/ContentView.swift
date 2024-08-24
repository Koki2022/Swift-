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
    @State private var arrayFileNames: [String] = []
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
                    // 新しい画像を選択する
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
                            // awaitは非同期関数 loadSelectedImages の完了を待機することを示している
                            await loadSelectedImages(items: items)
                        }
                    }
                }
            }
            // 保存ボタン
            Button(action: {
                // データ保存
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
            print("画面表示")
            // データ件数の確認
            checkCoreDataContent()
            // Core Dataから保存された画像を読み込み、selectedImagesにセット
            loadSavedImages()
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
    
    //　選択された画像を読み込む関数
    private func loadSelectedImages(items: [PhotosPickerItem]) async {
        // UIImage型の配列を用意
        var newImages: [UIImage] = []
        // String型の配列を用意
        var newFileNames: [String] = []
        
        for item in items {
            // 非同期でアイテムからデータを読み込みます。失敗した場合は次のアイテムに進む
            guard let data = try? await item.loadTransferable(type: Data.self),
                  // 読み込んだデータからUIImageを生成
                  let uiImage = UIImage(data: data),
                  // UIImageをファイルとして保存し、ファイル名を取得
                  /* 上記の処理が失敗した場合 else { continue } で現在のitemの処理をスキップして次のitemに進む。
                   問題のある項目を安全にスキップし、処理可能な項目のみを扱うことができる */
                    let fileName = saveImageAndGetFileName(image: uiImage) else { continue }
            newImages.append(uiImage)
            newFileNames.append(fileName)
        }
        // 非同期処理の結果をUIの更新に反映させる
        DispatchQueue.main.async {
            self.selectedImages = newImages
            self.arrayFileNames = newFileNames
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
            print("UIImageをストレージに保存しました。ファイル名: \(fileName)")
            // 保存したファイル名を返す
            return fileName
        } catch {
            print("画像の保存に失敗しました: \(error)")
            return nil
        }
    }
    // 追加ボタン押下した際にデータを保存する関数
    private func addPhotosItem() {
        // 画像が選択された時に、データを保存する処理を実行
        if arrayFileNames.isEmpty {
            print("画像なし")
        } else {
            // ファイル名に格納している配列の値を文字列で結合
            let fileNameString = arrayFileNames.joined(separator: ",")
            /* 保存ボタンを押した分だけ画像が増えてしまう問題 → 保存ボタンを押すたびに新しいエントリがCoreDataに追加されている
             ①保存前にCoreDataの既存エントリをチェックする
             ②既存エントリがある場合は更新し、ない場合のみ新規作成する */
            
            // 既存のエントリを探す
            let existingPhoto = fetchedPhotos.first
            
            if let photo = existingPhoto {
                // 既存のエントリを更新
                photo.fileName = fileNameString
                // 登録直前のデータ確認
                print("登録直前のデータ(既存): \(fileNameString)")
            } else {
                // 新しいエントリを作成してデータを保存
                let newPhoto = Photos(context: viewContext)
                newPhoto.fileName = fileNameString
                // 登録直前のデータ確認
                print("登録直前のデータ(新規): \(fileNameString)")
            }
            
            // 生成したインスタンスをCoreDataに保存する
            do {
                try viewContext.save()
                // CoreData登録直後のデータ確認
                print("CoreData登録直後のデータ: \(fileNameString)")
                // データ追加後に再度CoreDataの内容を確認
                checkCoreDataContent()
            } catch {
                print("ERROR \(error)")
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
    // アプリ起動時など保存された画像を読み込む関数
    private func loadSavedImages() {
        print("loadSavedImages関数実行")
        selectedImages = []
        for photo in fetchedPhotos {
            guard let fileNames = photo.fileName?.components(separatedBy: ",") else { continue }
            for fileName in fileNames {
                if let image = loadImageFromDocuments(fileName: fileName) {
                    selectedImages.append(image)
                }
            }
        }
    }
    // ファイル名を削除する関数
    private func deleteAllPhotos() {
        // CoreDataの情報を取り出す
        for photo in fetchedPhotos {
            // ファイル名の値をアンラップして処理
            if let fileName = photo.fileName {
                // 対応するドキュメントディレクトリを削除する関数の引数に代入
                deleteImageFromDocuments(fileName: fileName)
            }
            // 指定された photo オブジェクトをCore Dataのコンテキストから削除
            viewContext.delete(photo)
        }
        do {
            // ここで削除して情報を保存
            try viewContext.save()
            // UIImaege型のデータをすべて削除
            selectedImages.removeAll()
            print("すべての画像を削除しました")
        } catch {
            print("画像の削除中にエラーが発生しました: \(error)")
        }
    }
    // 対応する画像ファイルをドキュメントディレクトリから削除
    private func deleteImageFromDocuments(fileName: String) {
        // アプリのドキュメントディレクトリのURLを取得・
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // ドキュメントディレクトリ内に新しいファイルのURLを作成
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // 指定されたパスにファイルが存在するか確認
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // 指定されたURLのファイルを削除
                try FileManager.default.removeItem(at: fileURL)
                print("\(fileName) を削除しました")
            } catch {
                print("\(fileName) の削除に失敗しました: \(error)")
            }
        }
    }
    // ドキュメントディレクトリからUIImageを読み込む
    private func loadImageFromDocuments(fileName: String) -> UIImage? {
        // ドキュメントディレクトリのURLを取得
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        // 保存するファイルのフルパスを作成
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            return image
        } else {
            return nil
        }
    }
}

#Preview {
    ContentView()
}
