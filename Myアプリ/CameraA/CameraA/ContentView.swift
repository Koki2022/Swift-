//
//  ContentView.swift
//  CameraA
//
//  Created by 高橋昴希 on 2022/04/19.
//

import SwiftUI

struct ContentView: View {
    // 撮影した画像の変化に応じてViewを更新するため状態変数として宣言
    // 撮影画面で撮影された写真を保存して選択画面で写真を表示するために利用
    @State var captureImage: UIImage? = nil
    // 撮影画面（sheet）の開閉状態を管理
    @State var isShowSheet = false
    // フォトライブラリーかカメラかを保持する状態変数
    @State var isPhotolibrary = false
    // 選択画面（ActionSheet）のsheet開閉状態を管理
    @State var isShowAction = false
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                // 撮影写真を初期化
                captureImage = nil
                isShowAction = true
            }) {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            // isPresented:sheetの表示をコントロールする状態変数。$をつけて指定
            .sheet(isPresented: $isShowSheet) {
                if let unwrapCaptureImage = captureImage {
                    EffectView(
                    isShowSheet: $isShowSheet,
                    captureImage: unwrapCaptureImage)
                } else {
                    if isPhotolibrary {
                        PHPickerView(
                        isShowSheet: $isShowSheet,
                        captureImage: $captureImage)
                    } else {
                        ImagePickerView(
                        isShowSheet: $isShowSheet,
                        captureImage: $captureImage)
                    }
                }
            }
            
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                message: Text("選択してください"),
            buttons: [
                .default(Text("カメラ"), action: {
                    isPhotolibrary = false
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        print("カメラは利用できます")
                        isShowSheet = true
                    } else {
                        print("カメラは利用できません")
                    }
                }),
                .default(Text("フォトライブラリー"),
                         action: {
                             isPhotolibrary = true
                             isShowSheet = true
                         }),
                .cancel(),
            ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
