//: [Previous](@previous)

import Foundation

// 引数ラベルを設定しない
func outpuMessage(message: String) {
    print(message)
}
outpuMessage(message: "引数ラベルなしは、呼び出し元で引数名（入力パラメータ）を指定する必要があります。")


// 引数ラベルを指定
func outputMessageOnExternal(displayMessage message: String) {
    print(message)
}
outputMessageOnExternal(displayMessage: "引数ラベルを設定すると、呼び出し元と関数内で名前を使い分けることができます。")

// 引数ラベルを省略
func outputMessageNoneExternal(_ message: String) {
    print(message)
}
outputMessageNoneExternal("引数ラベルを省略すると、呼び出し元で引数名（入力パラメータ）を記述しなくてもOKです。")
