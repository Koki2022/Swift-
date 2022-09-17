//
//  ActivityView.swift
//  CameraA
//
//  Created by 高橋昴希 on 2022/04/19.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    // シェアする写真を管理する変数。UIActivityViewControllerへシェアしたいデータを渡すときに利用
    let shareItems: [Any]
    
    // 表示するViewを生成するときに実行
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        // UIActivityViewControllerの機能を持ったインスタンス変数controllerを生成。対象となるコンテンツを()内に引数で渡す
        // 引数activityItemsにシェアしたい画像を配列側で指定(複数あるかもしれないから)
        // applicationActivities:iOS標準として搭載されていないサービスを拡張する場合に指定
        let controller = UIActivityViewController(activityItems: shareItems,
                                                  applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>) {
        // 処理なし
    }
}

