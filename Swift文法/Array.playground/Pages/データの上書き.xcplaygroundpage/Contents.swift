//: [Previous](@previous)

import Foundation

var fruits = ["りんご", "いちご", "ぶどう"]
print(fruits)
fruits[1] = "スイカ"
print(fruits)

// 配列にデータを追加する方法
// ①append
fruits.append("キュウイ")
print(fruits)

// ②+=
fruits += ["メロン", "梨"]
print(fruits)

// ③contentsOfで複数の値を追加
fruits.append(contentsOf: ["いちご","みかん"])
print(fruits)

// ④インデックスを指定して、任意の場所に値を挿入
fruits.insert("グレープフルーツ", at: 1)
print(fruits)




// 配列からデータを削除する方法
// ①配列のインデックスを指定してデータを削除
fruits.remove(at: 1)
print(fruits)

// ②配列の先頭と最後の値を削除する方法
fruits.removeFirst()
print(fruits)
fruits.removeLast()
print(fruits)

// ③配列の全ての要素を削除する方法
fruits.removeAll()
print(fruits)
