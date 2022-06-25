//: [Previous](@previous)

import Foundation

// whileは、ある条件がfalseになるまで一連の処理を実行
// 最初の反復を開始する前に反復回数がわからない場合に最適
var count: Int = 1
while count < 10 { // 前判定ループ：countが10より小さい間は繰り返し実行
    print(count)
    count += 1
}

// repeat-while（後判定ループ）
var number: Int = 1
repeat {
    print(number)
    number += 1
} while number < 10 // countが10より小さい間は繰り返し実行

