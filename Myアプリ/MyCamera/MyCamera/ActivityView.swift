//
//  ActivityView.swift
//  MyCamera
//
//  Created by 高橋昴希 on 2022/04/15.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    
    let shareItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(
        activityItems: shareItems,
        applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {
        //　処理なし
    }
    
}


