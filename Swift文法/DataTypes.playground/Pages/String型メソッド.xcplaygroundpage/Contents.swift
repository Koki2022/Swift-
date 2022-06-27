//: [Previous](@previous)

import Foundation

// String型のメソッド

// count：文字数をカウント
var address = "東京都渋谷区"
print(address.count) // address変数の中が、6文字であることを確認

// replacingOccurrences：文字列置換
print(address) // 東京都渋谷区
address = address.replacingOccurrences(of: "渋谷区", with: "世田谷区")
print(address) // 東京都世田谷区

// replacingOccurrences：文字列削除
address = address.replacingOccurrences(of: "世田谷区", with: "")
print(address) // 東京都

// uppercased：文字列を大文字に変換
let greeting = "Hello, World"
print(greeting.uppercased()) // HELLO, WORLD

// lowercased：文字列を小文字に変換
print(greeting.lowercased()) // hello, world

// hasPrefix：先頭文字のチェック
// 文字列が指定されたキーワード（接頭辞）で始まるかをチェックしてBoole値（true or false）を返却します。
print(greeting) // Hello, World
print(greeting.hasPrefix("Hello")) // true
print(greeting.hasPrefix("World")) // false
// 大文字小文字を識別します。
print(greeting.hasPrefix("hello")) // false

// hasSuffix：末尾文字のチェック
// 文字列が指定されたキーワードで終了するかをチェックしてBoole値（true or false）を返却します。
print(greeting.hasSuffix("World")) // true
// 大文字小文字を識別します。
print(greeting.hasSuffix("world")) // false
