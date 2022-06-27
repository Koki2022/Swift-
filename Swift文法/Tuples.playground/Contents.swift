import UIKit

// タプル型：複数の型をまとめて一つの型にする
let mixDataType = (1, "こんにちは", true, 2.55)
print(mixDataType)
print(mixDataType.0)
print(mixDataType.1)
print(mixDataType.2)
print(mixDataType.3)
print(type(of: mixDataType))


// 同じ値を保持することも可能
let sameDataType = ("りんご", "りんご")
print(sameDataType)
print(type(of: sameDataType))


// データに名前をつける
let mixDataTypeOnLabel = (id: 10, message: "こんにちは", status: true, point: 2.55)
print(mixDataTypeOnLabel)
print(mixDataTypeOnLabel.id)
print(mixDataTypeOnLabel.message)
print(mixDataTypeOnLabel.status)
print(mixDataTypeOnLabel.point)
print(type(of: mixDataTypeOnLabel))

// タプルの値をまとめて定数・変数に代入
let (id, message, status, point) =  (1, "こんにちは", true, 2.55)

print(id)
print(message)
print(status)
print(point)


// 構造体とタプルの使い分け
// タプル：1回限りの使用、特に1つの関数から複数のデータを返したいときには最適
// 関数から任意の2つ以上の値を返したい場合はタプルを使用し、固定データを複数回利用したい場合は構造体を使用する

