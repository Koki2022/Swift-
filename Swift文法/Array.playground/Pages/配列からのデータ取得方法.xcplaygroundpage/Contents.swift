//: [Previous](@previous)

import Foundation

let fruits = ["りんご","いちご","ぶどう"]
// 1:添字を指定
print(fruits)
print(fruits[0])
print(fruits[1])
print(fruits[2])

// 2:メソッドで取得(データがオプショナルに変化)
print(fruits.first)
print(fruits.last)

// 警告の解除方法
// ①デフォルト値の設定
// ②強制アンラップ
// ③Any型にキャスト
