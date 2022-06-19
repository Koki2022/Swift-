//: [Previous](@previous)

import Foundation

// 浮動小数点型：Float型とDouble型
// 少数を型推論で代入するとデフォルトはDouble型

// Double型のメソッド

var score: Double = 10.523
// rounded：小数点以下を四捨五入
score = score.rounded()
print(score)  // 小数点以下が四捨五入され、11.0になることを確認

score = 10.523
// negate：符号の切り替え
print(score)   // 10.523であることを確認
score.negate() // 符号をスイッチ
print(score)   // 負の符号に変更されていることを確認
score.negate() // 符号をスイッチ
print(score)   // 正の符号に変更されていることを確認

// random：乱数を発生
print(Double.random(in: 10.0 ..< 20.0))
