//: [Previous](@previous)

import Foundation

// Nil結合演算子:対象の定数・変数がオプショナル型かチェックを行いある場合はアンラップをして値を返却
// optionalValue ?? defaultValue
// optionalValueに値がある場合は、アンラップを行います。
// optionalValueがnilの場合、デフォルト値（defaultValue）を返却します。

var name: String? = nil   // オプショナル型で宣言
print(name ?? "名無しさん") // nameに値がない（nil）ので、名無しさんが返却される

name = "はなこ"
print(name ?? "名無しさん") // nameに値があるので、アンラップを行いデータを返却
