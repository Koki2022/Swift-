//: [Previous](@previous)

import Foundation

// 型変換:処理対象、計算対象のデータ型を合わせる
//データの欠落が起きるリスクはないのか、意図的に欠落があっても大丈夫なのか、または欠落があってはいけないのかを明確にして型変換を実施

let intScore: Int = 200
let doubleScore: Double = 200.25

print(intScore + 100) // Int型とInt型で同じ型なので処理が可能

print(100 + 100.15) //　200.15と出力。リテラル同士の場合は違うデータ型でも計算が可能


// 型変換の方法を確認
print(type(of: intScore))  // Int型であることを確認
print(type(of: Double(intScore))) //　Int型をDouble型に型変換してDouble型であることを確認
print(type(of: doubleScore))  // Double型であることを確認
print(type(of: Int(doubleScore)))  //　Double型をInt型に型変換して、Int型であることを確認

// 以下、型変換を行って演算結果を確認
print(Double(intScore) + doubleScore) // Double型に合わせて計算、小数点以下のデータも正常
print(intScore + Int(doubleScore))    // Int型に合わせて計算、小数点以下のデータが欠落
