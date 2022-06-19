import UIKit

// 三項条件演算子:三つの項（被演算子）を用いて一つの結果を得る演算子
let firstPoint = 300
let secondPoint = 300

// 三項演算子を用いて、Bool値に応じてPrint出力
firstPoint == secondPoint ? print("同じ値だよ") : print("違う値だよ")

// 三項演算子の結果を定数に保持
let message = firstPoint == secondPoint ? "同じ値だよ" : "違う値だよ"
print(message)
