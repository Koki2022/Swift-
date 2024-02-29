//
//  ContentView.swift
//  TextFieldTest
//
//  Created by 高橋昴希 on 2024/02/29.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    var body: some View {
        TextField("キーワードを入力", text: $inputText)
            .textFieldStyle(.roundedBorder)
            .background(Color.gray)
            .padding(20)
    }
}

#Preview {
    ContentView()
}
