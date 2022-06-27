//: [Previous](@previous)

import Foundation

// Int型の便利なメソッド

// negate：符号の切り替え
var score: Int = 10
print(score)   // 10であることを確認
score.negate() // 符号をスイッチ
print(score)   // 負の符号に変更されていることを確認
score.negate() // 符号をスイッチ
print(score)   // 正の符号に変更されていることを確認

// random：乱数を発生
print(Int.random(in: 0...100)) // 0〜100の間で乱数を発生

// isMultiple：引数の倍数であるかをチェックして真偽値を返却
print(score.isMultiple(of: 2)) // 2の倍数なので、trueを返却
print(score.isMultiple(of: 3)) // 3の倍数ではないので、falseを返却
