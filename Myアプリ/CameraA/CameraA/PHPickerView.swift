//
//  PHPickerView.swift
//  CameraA
//
//  Created by 高橋昴希 on 2022/04/20.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    
    @Binding var isShowSheet: Bool
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject,
                       PHPickerViewControllerDelegate {
        var parent: PHPickerView
        init(parent:PHPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController,
                    didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                result.itemProvider.loadObject(ofClass: UIImage.self) {
                    (image, error) in
                    if let unwrapImage = image as? UIImage {
                        self.parent.captureImage = unwrapImage
                    } else {
                        print("使用できる写真がないです")
                    }
                }
                parent.isShowSheet = true
            } else {
                print("選択された写真はないです")
                parent.isShowSheet = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Viewを生成するときに実行
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<PHPickerView>)
        -> PHPickerViewController {
        // PHPickerViewControllerのカスタマイズ
        var configuration = PHPickerConfiguration()
        // 静止画を選択
        configuration.filter = .images
        // フォトライブラリーで選択できる枚数を1枚にする
        configuration.selectionLimit = 1
        // PHPickerViewControllerのインスタンスを生成
        let picker = PHPickerViewController(configuration: configuration)
        // delegate設定
        picker.delegate = context.coordinator
        // PHPickerViewControllerを返す
        return picker
    }
    
    // Viewが更新されたときに実行
    func updateUIViewController(
        _ uiViewController: PHPickerViewController,
        context: UIViewControllerRepresentableContext<PHPickerView>)
    {
        // 処理なし
    }
  
}
