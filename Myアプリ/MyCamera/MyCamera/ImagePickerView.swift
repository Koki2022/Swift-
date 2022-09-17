//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by 高橋昴希 on 2022/04/11.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    // UIImagePickerControllerが表示されているか管理
    @Binding var isShowSheet: Bool
    
    // 撮影した写真を格納する変数
    // UIImageクラスは画像を管理するクラス
    // 撮影後の写真を共有するためcaptureImageをUIImage型で宣言
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let originalImage =
                info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage {
                parent.captureImage = originalImage
            }
            parent.isShowSheet = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) ->
    UIImagePickerController {
        
        let myImagePickerController = UIImagePickerController()
        
        myImagePickerController.sourceType = .camera
        
        myImagePickerController.delegate = context.coordinator
        
        return myImagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        // 処理なし
    }
}


