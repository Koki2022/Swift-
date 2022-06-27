//: [Previous](@previous)

import Foundation

// Bool型メソッド

// togle：真偽値をスイッチ
var isSelect = false
print(isSelect) // falseであることを確認
isSelect.toggle()
print(isSelect) // trueにスイッチされていることを確認

// ランダムに、true or falseを発生
print(Bool.random())
