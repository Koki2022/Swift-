//: [Previous](@previous)

import Foundation

// String型の文字列操作

// 文字列の結合
print("東京都" + "渋谷区") // 東京都渋谷区

// String型の定数を結合
let region = "東京都"
let city = "渋谷区"
print(region + city) // 東京都渋谷区

// 文字列の追加
var greeting = "こんにちは！"
greeting.append("プログラミング")
print(greeting) // こんにちは, プログラミング

// 文字列の追加
greeting += "がんばるぞ！"
print(greeting) // こんにちは,プログラミングがんばるぞ！

// 文字列内で定数（変数）を展開
// 文字列の中に、定数や変数を埋め込む（展開）することができます。
print("みなさん、\(greeting)よろしくね！") // みなさん、こんにちは！プログラミングがんばるぞ！よろしくね！





