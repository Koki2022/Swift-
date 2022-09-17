//
//  ImagePickerView.swift
//  CameraA
//
//  Created by 高橋昴希 on 2022/04/19.
//

import SwiftUI

// SwiftUIでカメラ機能を利用する場合、UIViewControllerRepresentable を適合させたStructを作成します。さらに、SwiftUIとUIKit間の動作をサポートするCoodinator クラスと関係するメソッドを作成します。
struct ImagePickerView: UIViewControllerRepresentable {
    
    //Coordinatorクラスの追加
    // 撮影画面の表示状態を管理
    @Binding var isShowSheet: Bool
    // UIImageクラスは画像を管理するクラス
    @Binding var captureImage: UIImage?
    
    // Coordinatorを宣言して機能を実現するためのプロトコルなどを追加
    class Coordinator: NSObject,
    UINavigationControllerDelegate,
                       UIImagePickerControllerDelegate {
        
        // Coordinatorクラスのインスタンス生成の時、Coordinatorを利用しやすくする親を指定
        // 親の値を直接編集するとは？
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // imagePickerControllerメソッドの追加
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage]
                // Any型からUIImage型へ型変換
                as? UIImage {
                parent.captureImage = originalImage
            }
            parent.isShowSheet = true
        }
        
        //imagePickerControllerDidCancelメソッドの追加
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet = false
        }
    }
    
    // CoordinatorクラスとUIViewControllerRepresentableプロトコルに必要なメソッド追加
    // makeCoordinatorの追加
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // makeUIViewControllerの追加
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) ->
    UIImagePickerController {
        //UIImagePickerControllerクラスのインスタンスのmyImagePickerControllerオブジェクトを生成し、撮影画面のオプションを設定する
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.sourceType = .camera
        myImagePickerController.delegate = context.coordinator
        return myImagePickerController
    }
    // updateUIViewControllerの追加
    func updateUIViewController(
        _ uiViewController: UIImagePickerController, context:
        UIViewControllerRepresentableContext<ImagePickerView>) {
        // 処理なし
    }
}

