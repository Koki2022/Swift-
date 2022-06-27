import UIKit

// リテラルのデータ型を、typeを利用して確認
print(type(of: 100))
print(type(of: 132.5))
print(type(of: "こんにちは"))
print(type(of: true))

// 型推論：簡潔に記述ができる
// 型指定：定義を見る時に明示されているので分かりやすい
// 定数にそれぞれのリテラルを格納
// 代入のタイミングで型推論でデータ型が決定される

let intScore = 200
let doubleScore = 200.25
let message: String = "こんにちは"
let selected: Bool = false

print(type(of: intScore))
print(type(of: doubleScore))
print(type(of: message))
print(type(of: selected))

// 初期値を代入せずに型の宣言のみをする方法
// let 定数名: データ型
// var 変数名: データ型
// 定数・変数は初期値が代入されてはじめて利用可能
