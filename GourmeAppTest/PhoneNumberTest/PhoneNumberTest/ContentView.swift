//
//  ContentView.swift
//  PhoneNumberTest
//
//  Created by 高橋昴希 on 2024/10/16.
//

import SwiftUI

struct PhoneNumberView: View {
    @State private var phoneNumber: String = ""

    var body: some View {
        VStack {
            // 電話番号を入力するTextField
            TextField("電話番号を入力してください", text: $phoneNumber)
                .padding()
                .keyboardType(.phonePad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // タップで電話をかけるLink
            if let url = URL(string: "tel:\(phoneNumber)"), !phoneNumber.isEmpty {
                Link("この番号に電話をかける", destination: url)
                    .padding()
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

#Preview {
    PhoneNumberView()
}
