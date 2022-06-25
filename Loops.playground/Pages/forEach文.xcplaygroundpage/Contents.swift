//: [Previous](@previous)

import Foundation

// シーケンス内（順序をもった配列など）の各要素に対して、for-inループと同じ順序で値を取り出して処理を行う
/*  forEachで取り出した値はデフォルトで「$0」に格納。「$0」を定数のように利用して処理を行うことができる

 // シーケンス.forEach {
     print($0) // シーケンスから、ひとつずつ取り出された値が「$0」に格納されます。
 }

//ループの中で使う定数名も利用することができる

 シーケンス.forEach { 定数名 in
     print(定数名) // シーケンスから、ひとつずつ取り出された値が、定数に格納されます。
 }
 
 可読性の観点から、定数に格納する方法が望ましい。配列から取り出した値がどんな特性を持つデータなのか、というのを定数名に分かりやすく表現することで可読性が高まる*/

let numberWords = ["ひとつ", "ふたつ", "みっつ"]

numberWords.forEach {
    print($0)
}

// forEachでループ処理
numberWords.forEach { word in
    print(word)
}

// for-inでループ処理
for word in numberWords {
    print(word)
}


// for-inとforEachの使い分け
// 特定の条件下で、ループ処理全体を処理を中断させたい場合,または処理をスキップしたい場合はfor-in文
// 制御転送文

// break文:ある特定の条件下で処理を抜け出す
let number = ["one", "two", "three", "four", "five"]
// for-in文での、break処理
for word in number {
    if word == "three" {
        break
    }
    print(word)
}

// continue文:ループの処理を一旦停止し、次のループの先頭から再び開始
let words = ["one", "two", "three", "four", "five"]
// for-in文での、continue処理
for word in words {
    if word == "three" {
        continue 
    }
    print(word)
}
